variable "aws_profile" {
    type = string
    description = "AWS credentials profile to use to connect"
    default = ""
}

variable "controller_name" {
  type = string
  default = "Terraform"
}

variable "aws_region" {
  type = string
  description = "AWS region to use"
  default = "ap-south-1"
}

variable "aws_ec2_instance_type" {
  type = string
  default = "t2.micro"
}

variable "aws_ec2_instance_name" {
  type = string
  default = "Terrafrom-instance"
}

variable "ami_id" {
  type = string
}


variable "vpc_name" {
    type = string
    description = "Name of the VPC"
    default = "Terraform VPC"
}

variable "vpc_ipv4_cidr" {
    type = string
    description = "VPC CIDR Range"
    default = "10.10.0.0/16"
}


variable "public_subnet_names" {
    type = string
    default = "public-subnet"
}

variable "public_subnet_count" {
  type = string
  default = 1
}


variable "private_subnet_name" {
    type = string
    default = "private-subnet" 
}


variable "private_subnet_count" {
  type = string
  default = 1
}
