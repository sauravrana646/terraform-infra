locals {
  aws_ec2_instance_name = "${var.aws_ec2_instance_name}-${var.controller_name}"
}

data "local_file" "aws_ec2_public_key_path" {
  filename = "${path.cwd}/${var.aws_ec2_public_key_filename}"
}

resource "aws_key_pair" "tf_ec2_key_pair" {
  key_name   = var.aws_ec2_public_key_name
  public_key = data.local_file.aws_ec2_public_key_path.content
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  dynamic ingress {
    for_each = toset(var.ingress_tcp_ports)
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
      "Name" = "${var.aws_ec2_sg_name}"
      "ManagedBy" = "${var.controller_name}"
    }
}


resource "aws_instance" "tf_ec2" {
  depends_on = [
    aws_key_pair.tf_ec2_key_pair
  ]
    ami = var.ami_id
    instance_type = var.aws_ec2_instance_type
    associate_public_ip_address = false
    availability_zone = var.aws_ec2_availability_zone
    tags = {
      "Name" = "${local.aws_ec2_instance_name}"
      "ManagedBy" = "${var.controller_name}"
    }
}