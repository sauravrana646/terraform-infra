# Generate ssh-key using this command
#ssh-keygen -m PEM


# AWS Variables
aws_region      = "ap-south-1"
controller_name = "saurav"
main_name       = "daffo-prod"


# EC2 Variables
ami_id                      = "ami-068257025f72f470d"
aws_ec2_instance_type       = "t2.small"
aws_ec2_public_key_filename = "tf-key.pub"


# VPC Variables
vpc_ipv4_cidr = "11.11.0.0/16"

