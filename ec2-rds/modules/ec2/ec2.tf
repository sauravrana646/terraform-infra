locals {
    instance_name = "${var.instance_name}-${var.controller_name}"
}

resource "aws_instance" "ec2_temp" {
    ami = var.ami_id
    instance_type = var.aws_instance_type
    associate_public_ip_address = false
    tags = {
      "Name" = "${local.instance_name}"
      "ManagedBy" = "${var.controller_name}"
    }
}