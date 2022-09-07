resource "aws_db_parameter_group" "tf_rds_parameter_group" {
  name        = "${var.main_name}-rds-parameter-grp"
  family      = "mysql8.0"
  description = "RDS parameter group for ${var.main_name}"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

resource "aws_db_subnet_group" "tf_rds_subnet_group" {
  name       = "${var.main_name}-rds-subnet-group"
  subnet_ids = tolist(var.rds_private_subnet_ids[*].id)

  tags = {
    "Name"      = "${var.main_name}-rds-subnet-group"
    "ManagedBy" = "${var.controller_name}"
  }
}

resource "aws_security_group" "tf_rds_sg" {
  description = "Allow Inbound from EC2"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow Inbound from EC2"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    # cidr_blocks      = [aws_vpc.main.cidr_block]
    security_groups  = [var.ec2_security_group_id]
    ipv6_cidr_blocks = null
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name"      = "${var.main_name}-rds-security-group"
    "ManagedBy" = "${var.controller_name}"
  }
}

resource "aws_db_instance" "tf_rds_instance" {
  depends_on = [
    aws_db_parameter_group.tf_rds_parameter_group,
    aws_db_subnet_group.tf_rds_subnet_group
  ]
  allocated_storage       = 30
  max_allocated_storage   = var.rds_maximum_storage
  identifier              = "${var.main_name}-rds-instance"
  engine                  = "mysql"
  engine_version          = var.rds_database_version
  instance_class          = var.rds_instance_type
  db_name                 = "mydb"
  username                = var.rds_admin_username
  password                = var.rds_admin_password
  parameter_group_name    = aws_db_parameter_group.tf_rds_parameter_group.name
  db_subnet_group_name    = aws_db_subnet_group.tf_rds_subnet_group.name
  publicly_accessible     = false
  storage_type            = "gp2"
  backup_retention_period = 30
  skip_final_snapshot     = true
  vpc_security_group_ids = [aws_security_group.tf_rds_sg.id]
  # tags = {
  #   "Name"      = "${var.main_name}-rds-instance"
  #   "ManagedBy" = "${var.controller_name}"
  # }
}