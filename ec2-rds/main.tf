module "ec2" {
  depends_on = [
    module.vpc
  ]
  source                                = "./modules/ec2/"
  main_name                             = var.main_name
  controller_name                       = var.controller_name
  ami_id                                = var.ami_id
  aws_ec2_instance_type                 = var.aws_ec2_instance_type
  aws_ec2_count                         = var.aws_ec2_count
  ec2_root_volume_delete_on_termination = var.ec2_root_volume_delete_on_termination
  ec2_root_volume_size                  = var.ec2_root_volume_size
  ec2_associate_eip                     = var.ec2_associate_eip
  additional_ebs_size                   = var.additional_ebs_size
  ec2_ssh_user                          = var.ec2_ssh_user
  aws_ec2_public_key_filename           = var.aws_ec2_public_key_filename
  ec2_ssh_private_key_pem_path          = var.ec2_ssh_private_key_pem_path
  vpc_id                                = module.vpc.vpc_id
  ec2_public_subnet_ids                 = module.vpc.public_subnet_ids
}

module "vpc" {
  source               = "./modules/vpc"
  main_name            = var.main_name
  controller_name      = var.controller_name
  vpc_ipv4_cidr        = var.vpc_ipv4_cidr
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  # ec2_subnet_id = var.ec2_subnet_id
}

module "rds" {
  source                 = "./modules/rds"
  main_name              = var.main_name
  controller_name        = var.controller_name
  rds_admin_username     = var.rds_admin_username
  rds_admin_password     = var.rds_admin_password
  rds_private_subnet_ids = module.vpc.private_subnet_ids
}

resource "local_file" "ansible-vars" {
  content = <<-DOC
  hosts: tag_ManagedBy_${var.controller_name}
  remote_user : "${var.ec2_ssh_user}"
  ansible_private_key_file : "${var.ec2_ssh_private_key_pem_path}"
  DOC
  filename = "../../ansible-infra/main/tf-ansible-vars.yml" 
}

resource "local_file" "dynamic-inventory-ansible" {
  content = <<-DOC
  ---
  plugin: amazon.aws.aws_ec2
  aws_profile: ${var.aws_profile}
  regions:
  - ${var.aws_region}
  keyed_groups:
  - key: tags
    prefix: tag
  filters:
    instance-state-name : running
  compose:
    ansible_host: public_ip_address
  DOC
  filename = "../../ansible-infra/inventory/aws_ec2.yaml" 
}

resource "null_resource" "ansible-exec" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    working_dir = "../../ansible-infra/"
    command = "ansible-playbook main/main.yaml"
  }
}