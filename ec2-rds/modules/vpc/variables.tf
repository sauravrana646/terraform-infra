variable "controller_name" {
    type = string
    default = "Terraform"
  
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
