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
  region  = var.aws_region
}

module "ec2" {
  depends_on = [
    module.vpc
  ]
  source                      = "./modules/ec2/"
  ami_id                      = var.ami_id
  aws_ec2_instance_type       = var.aws_ec2_instance_type
  main_name                   = var.main_name
  controller_name             = var.controller_name
  aws_ec2_public_key_filename = var.aws_ec2_public_key_filename
  vpc_id                      = module.vpc.vpc_id
  ec2_associate_eip = var.ec2_associate_eip
  ec2_ssh_user = var.ec2_ssh_user
  ec2_ssh_private_key_pem_path = var.ec2_ssh_private_key_pem_path
  ec2_subnet_ids = module.vpc.subnet_ids
}

module "vpc" {
  source          = "./modules/vpc"
  main_name       = var.main_name
  vpc_ipv4_cidr   = var.vpc_ipv4_cidr
  controller_name = var.controller_name
  public_subnet_count = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  # ec2_subnet_id = var.ec2_subnet_id
}