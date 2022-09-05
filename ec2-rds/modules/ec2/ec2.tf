# locals {
#   associate_public_ip_address = var.ec2_associate_eip ? false : true
#   aws_eip_count = var.ec2_associate_eip ? var.aws_ec2_count : 0
# }

data "local_file" "aws_ec2_public_key_path" {
  filename = "${path.cwd}/${var.aws_ec2_public_key_filename}"
}

data "aws_availability_zones" "tf_vpc_az" {
  state = "available"
}

data "aws_subnets" "tf_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}


resource "aws_key_pair" "tf_ec2_key_pair" {
  key_name   = "${var.main_name}-key"
  public_key = data.local_file.aws_ec2_public_key_path.content
}

resource "aws_security_group" "tf_sg" {
  name        = "${var.main_name}-sg"
  description = "Security Group for ${var.main_name}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = toset(var.sg_ingress_rules)
    content {
      description      = "${var.main_name}-ingress-rule"
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_blocks      = ingress.value["from_ipv4_cidr"]
      ipv6_cidr_blocks = ingress.value["from_ipv6_cidr"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    "Name"      = "${var.main_name}-sg"
    "ManagedBy" = "${var.controller_name}"
  }
}

resource "aws_eip" "tf_eip" {
  # count = local.aws_eip_count
  count    = var.ec2_associate_eip ? var.aws_ec2_count : 0
  instance = aws_instance.tf_ec2[count.index].id
  vpc      = true
  tags = {
    "Name"      = "${var.main_name}-eip-${count.index}"
    "ManagedBy" = "${var.controller_name}"
  }
}

resource "aws_ebs_volume" "tf_additional_ebs" {
  count             = var.aws_ec2_count
  availability_zone = var.ec2_public_subnet_ids[count.index].availability_zone
  size              = var.additional_ebs_size

  tags = {
    "Name"      = "${var.main_name}-additional-ebs-${count.index}"
    "ManagedBy" = "${var.controller_name}"
  }
}

resource "aws_volume_attachment" "tf_additional_ebs_attachment" {
  count       = var.aws_ec2_count
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.tf_additional_ebs[count.index].id
  instance_id = aws_instance.tf_ec2[count.index].id
}


resource "aws_instance" "tf_ec2" {
  depends_on = [
    aws_key_pair.tf_ec2_key_pair,
    aws_security_group.tf_sg
  ]
  count         = var.aws_ec2_count
  ami           = var.ami_id
  instance_type = var.aws_ec2_instance_type
  # associate_public_ip_address = local.associate_public_ip_address
  # associate_public_ip_address = true
  # availability_zone           = data.aws_availability_zones.tf_vpc_az.names[count.index % length(data.aws_availability_zones.tf_vpc_az.names)]
  availability_zone      = var.ec2_public_subnet_ids[count.index].availability_zone
  vpc_security_group_ids = [aws_security_group.tf_sg.id]
  # subnet_id                   = tolist(data.aws_subnets.tf_vpc_subnets.ids)[count.index % length(data.aws_subnets.tf_vpc_subnets.ids)]
  subnet_id = var.ec2_public_subnet_ids[count.index].id
  key_name  = aws_key_pair.tf_ec2_key_pair.key_name

  root_block_device {
    delete_on_termination = var.ec2_root_volume_delete_on_termination
    tags = {
      "Name"      = "${var.main_name}-ebs"
      "ManagedBy" = "${var.controller_name}"
    }
    volume_size = var.ec2_root_volume_size
    volume_type = "gp2"
  }
  tags = {
    "Name"      = "${var.main_name}-instance-${count.index}"
    "ManagedBy" = "${var.controller_name}"
  }
}

resource "null_resource" "execute_ssh" {
  depends_on = [
    aws_instance.tf_ec2
  ]
  count = var.aws_ec2_count
  connection {
    type        = "ssh"
    user        = var.ec2_ssh_user
    private_key = file(var.ec2_ssh_private_key_pem_path)
    host        = aws_eip.tf_eip[count.index].public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "whoami",
      "hostname",
      "echo \"Done\""
    ]

  }
}

