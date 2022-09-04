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

variable "rds_private_subnet_ids" {
  type = any

}

variable "rds_admin_password" {
  type = string
}

variable "rds_admin_username" {
  type = string
}

variable "rds_database_version" {
  type    = string
  default = "8.0.28"
}

variable "rds_instance_type" {
  type    = string
  default = "db.t3.micro"
}

variable "rds_maximum_storage" {
  type    = number
  default = 50
}