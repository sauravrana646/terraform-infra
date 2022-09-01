variable "aws_profile" {
  type        = string
  description = "AWS credentials profile to use to connect"
  default     = ""
}
variable "main_name" {
  type    = string
  default = "Terraform"
}

variable "controller_name" {
  type    = string
  default = "Terraform"
}

variable "aws_region" {
  type        = string
  description = "AWS region to use"
  default     = "ap-south-1"
}

variable "aws_ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_id" {
  type = string
}

variable "vpc_ipv4_cidr" {
  type        = string
  description = "VPC CIDR Range"
  default     = "10.10.0.0/16"
}

variable "public_subnet_count" {
  type    = string
  default = 1
}

variable "private_subnet_count" {
  type    = string
  default = 1
}

variable "aws_ec2_public_key_filename" {
  type = string
}

