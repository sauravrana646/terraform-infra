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
  aws_instance_type = var.instance_type
  instance_name = var.instance_name
  controller_name = var.controller_name

}

module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  controller_name = var.controller_name
  
}