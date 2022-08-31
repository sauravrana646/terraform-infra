variable "aws_profile" {
    type = string
    description = "AWS credentials profile to use to connect"
    default = ""
}

variable "aws_region" {
  type = string
  description = "AWS region to use"
  default = "ap-south-1"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "instance_name" {
  type = string
  default = "Terrafrom-instance"
}

variable "ami_id" {
  type = string
}

variable "vpc_name" {
  type = string
  default = "Terraform-VPC"
}

variable "vpc_cidr" {
  type = string
  default = "10.10.0.0/16"
}

variable "controller_name" {
  type = string
  default = "Terraform"
}