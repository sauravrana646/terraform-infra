variable "controller_name" {
  type =string
  default = "terraform"
}

variable "ami_id" {
  type = string
}

variable "aws_ec2_instance_name" {
  type = string
  default = "test"
}

variable "aws_ec2_instance_type" {
  type = string
  default = "t2.micro"
}

variable "aws_ec2_availability_zone" {
  type = string
  default = "ap-south-1a"
}

variable "aws_ec2_public_key_name" {
  type = string
  default = "Terraform-key"
}

variable "aws_ec2_public_key_filename" {
  type = string
  default = "aws.pem.pub"
}

variable "aws_ec2_sg_name" {
  type = string
  default = "terraform-ec2-sg"
}


