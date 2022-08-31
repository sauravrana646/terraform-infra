variable "controller_name" {
  type =string
  default = "terraform"
}

variable "ami_id" {
  type = string
}

variable "instance_name" {
  type = string
  default = "test"
}

variable "aws_instance_type" {
  type = string
  default = "t2.micro"
}


