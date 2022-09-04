variable "vpc_id" {
  type        = string
  description = "VPC Id retrived automatically from the VPC Module"
}

variable "ec2_public_subnet_ids" {
  type = any
}

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
  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^ami-", var.ami_id))
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "aws_ec2_instance_type" {
  type        = string
  description = "Instance type for EC2"
  default     = "t2.micro"
}

variable "aws_ec2_public_key_filename" {
  type        = string
  description = "Name of the public key file"
}


variable "aws_ec2_count" {
  type        = number
  description = "Number of Ec2 Instances to launch"
  default     = 1
}

variable "ec2_root_volume_delete_on_termination" {
  type        = bool
  description = "Delete root ebs volume upon ec2 termination"
  default     = true
}

variable "ec2_root_volume_size" {
  type        = number
  description = "Size of root ebs volume in GiB"
  default     = 10
}

variable "ec2_associate_eip" {
  type = bool
  # default = false
}

variable "additional_ebs_size" {
  type    = number
  default = 10
}

variable "ec2_ssh_user" {
  type    = string
  default = "ec2-user"
}

variable "ec2_ssh_private_key_pem_path" {
  type    = string
  default = "~/.ssh/id_rsa"
}

variable "sg_ingress_rules" {
  type = list(object({
    from_port      = number
    to_port        = number
    protocol       = string
    from_ipv4_cidr = list(string)
    from_ipv6_cidr = list(string)
  }))

  description = "List of Security Group Ingress Rules for EC2"

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
      from_ipv4_cidr = ["0.0.0.0/0"]
      from_ipv6_cidr = null
    }
  ]
}



