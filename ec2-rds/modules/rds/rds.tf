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

resource "aws_db_instance" "tf_rds_instance" {
  depends_on = [
    aws_db_parameter_group.tf_rds_parameter_group,
    aws_db_subnet_group.tf_rds_subnet_group
  ]
  allocated_storage       = 30
  max_allocated_storage   = var.rds_maximum_storage
  identifier              = "${var.main_name}-rds-instance-identifier"
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
}