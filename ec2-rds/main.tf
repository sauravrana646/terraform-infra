terraform {
    required_version = "~> 1.2.8"
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
  }
}
provider "aws" {
    profile = var.aws_profile
    region = var.aws_region 
}

module "ec2" {
  source = "./modules/ec2/"
  ami_id = var.ami_id
  aws_ec2_instance_type = var.aws_ec2_instance_type
  aws_ec2_instance_name = var.aws_ec2_instance_name
  controller_name = var.controller_name

}

module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
  vpc_ipv4_cidr = var.vpc_ipv4_cidr
  controller_name = var.controller_name
}