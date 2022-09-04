variable "controller_name" {
  type        = string
  description = "Management Tag for the resources"
  default     = "Terraform"
}

variable "main_name" {
  type        = string
  description = "Prefix name for the resources"
  default     = "Terraform"
}

variable "vpc_ipv4_cidr" {
  type        = string
  description = "VPC CIDR Range"
  default     = "10.10.0.0/16"
}

variable "public_subnet_count" {
  type        = number
  description = "Number of Public Subnets to launch"
  default     = 1
}

variable "private_subnet_count" {
  type        = number
  description = "Number of Private Subnets to launch"
  default     = 1
}
