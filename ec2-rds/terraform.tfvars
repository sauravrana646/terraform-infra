# Generate ssh-key in PEM format using this command for EC2
#ssh-keygen -m PEM


# AWS Variables
aws_region      = "ap-south-1"
aws_profile     = ""
controller_name = "saurav"
main_name       = "daffo-prod"


# VPC Variables
# vpc_ipv4_cidr        = "11.11.0.0/16"
public_subnet_count  = 1
private_subnet_count = 2


# EC2 Variables
ami_id                                = "ami-068257025f72f470d"
aws_ec2_instance_type                 = "t2.small"
aws_ec2_count                         = 1
ec2_root_volume_delete_on_termination = true
ec2_root_volume_size                  = 9
ec2_associate_eip                     = true
additional_ebs_size                   = 5
ec2_ssh_user                          = "ubuntu"
# aws_ec2_public_key_filename           = "tf-key.pub"
aws_ec2_public_key_filename = "aws.pem.pub"
# ec2_ssh_private_key_pem_path = "E:/Terraform-Learning/Unthinkable-tf/tf-key"
ec2_ssh_private_key_pem_path = "~/aws-key/aws.pem"
# sg_ingress_rules = [{
#   from_ipv4_cidr = ["value"]
#   from_ipv6_cidr = ["value"]
#   from_port      = 1
#   protocol       = "value"
#   to_port        = 1
# }]



# RDS Variables
rds_admin_username   = "admin"
rds_admin_password   = "admin123"
rds_database_version = "8.0.28"
rds_instance_type    = "db.t3.micro"
rds_maximum_storage  = 50
