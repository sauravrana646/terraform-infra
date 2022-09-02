# Generate ssh-key using this command
#ssh-keygen -m PEM


# AWS Variables
aws_region      = "ap-south-1"
controller_name = "saurav"
main_name       = "daffo-prod"


# EC2 Variables
ami_id                      = "ami-068257025f72f470d"
aws_ec2_instance_type       = "t2.small"
aws_ec2_public_key_filename = "aws.pem.pub"
ec2_associate_eip = true
ec2_ssh_user = "ubuntu"
ec2_ssh_private_key_pem_path = "~/aws-key/aws.pem"
# ec2_subnet_id = "ap-south-"


# VPC Variables
vpc_ipv4_cidr = "11.11.0.0/16"
private_subnet_count = 1
public_subnet_count = 1

