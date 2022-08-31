provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "aws_ami_temp" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

/* resource "aws_instance" "ec2_temp" {
    ami = tostring(data.aws_ami.aws_ami_temp.id)
    instance_type = "t2.micro"

} */

output "image_id" {
    value = "${data.aws_ami.aws_ami_temp}"
}