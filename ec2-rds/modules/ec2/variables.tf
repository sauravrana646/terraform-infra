variable "main_name" {
  type        = string
  description = "Prefix name for the resources"
  default     = "Terraform"
}

variable "controller_name" {
  type        = string
  description = "Management Tag for the resources"
  default     = "Terraform"
}

variable "ami_id" {
  type        = string
  description = "AMI Id for the EC2 Instance"
}

variable "aws_ec2_instance_type" {
  type        = string
  description = "Instance type for EC2"
  default     = "t2.micro"
}

variable "aws_ec2_availability_zone" {
  type        = string
  description = "Availability Zone to launch EC2 in"
  default     = "ap-south-1a"
}

variable "aws_ec2_public_key_filename" {
  type        = string
  description = "Name of the public key file"
}

variable "vpc_id" {
  type        = string
  description = "VPC Id retrived automatically from the VPC Module"
}

variable "aws_ec2_count" {
  type    = number
  default = 1
}

variable "sg_ingress_rules" {
  type = list(object({
    from_port      = number
    to_port        = number
    protocol       = string
    from_ipv4_cidr = list(string)
    from_ipv6_cidr = list(string)
  }))

  description = "List of Security Group Rules for EC2"

  default = [{
    from_port      = 80
    protocol       = "tcp"
    to_port        = 80
    from_ipv4_cidr = ["0.0.0.0/0"]
    from_ipv6_cidr = null
    },
    {
      from_port      = 443
      to_port        = 443
      protocol       = "tcp"
      from_ipv4_cidr = ["0.0.0.0/0"]
      from_ipv6_cidr = null
    },
    {
      from_port      = 22
      to_port        = 22
      protocol       = "tcp"
      from_ipv4_cidr = ["10.10.0.0/16", "0.0.0.0/0"]
      from_ipv6_cidr = null
    }
  ]
}

