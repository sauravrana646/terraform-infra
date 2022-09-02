variable "aws_profile" {
  type        = string
  description = "AWS credentials profile to use to connect"
  default     = ""
}
variable "main_name" {
  type    = string
}

variable "controller_name" {
  type    = string
  default = "Terraform"
}

variable "aws_region" {
  type        = string
  description = "AWS region to use"
}

variable "aws_ec2_instance_type" {
  type    = string
}

variable "ami_id" {
  type = string
}

variable "vpc_ipv4_cidr" {
  type        = string
  description = "VPC CIDR Range"
}

variable "public_subnet_count" {
  type    = string
}

variable "private_subnet_count" {
  type    = string
}

variable "aws_ec2_public_key_filename" {
  type = string
}

variable "ec2_associate_eip" {
  type = bool
  # default = false
}

variable "ec2_ssh_user" {
  type = string
}

variable "ec2_ssh_private_key_pem_path" {
  type = string
}

# variable "ec2_subnet_id" {
#   type = string
# }

