variable "controller_name" {
    type = string
    default = "Terraform"
  
}
variable "vpc_name" {
    type = string
    description = "Name of the VPC"
    default = "Terraform VPC"
  
}

variable "vpc_cidr" {
    type = string
    description = "VPC CIDR Range"
    default = "10.10.0.0/16"
}

variable "public_subnet_names" {
    type = list
    default = ["public-subnet-1a", "public-subnet-1b" ]
}

variable "public_subnet_count" {
  type = string
  default = 2
}

variable "aws_public_subnet_cidr" {
  type = list
  default = ["10.10.1.0/24", "10.10.2.0/24"]

}

variable "private_subnet_names" {
    type = list
    default = ["private-subnet-1a", "private-subnet-1b" ]
}

variable "private_subnet_count" {
  type = string
  default = 0
}

variable "aws_private_subnet_cidr" {
  type = list
  default = ["10.10.3.0/24", "10.10.4.0/24"]

}