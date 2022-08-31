resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vpc_name}"
    ManagedBy = "${var.controller_name}"
  }
}

resource "aws_subnet" "main_public_subnet" {
    /* for_each = toset(var.public_subnet_names) */
    vpc_id     = aws_vpc.main.id
    cidr_block = var.aws_public_subnet_cidr["${count.index}"]
    count = var.public_subnet_count
    tags = {
        Name = var.public_subnet_names["${count.index}"]
        ManagedBy = "${var.controller_name}"
  }
}

resource "aws_subnet" "main_private_subnet" {
    /* for_each = toset(var.private_subnet_names) */
    vpc_id     = aws_vpc.main.id
    cidr_block = var.aws_private_subnet_cidr["${count.index}"]
    count = var.private_subnet_count
    tags = {
        Name = var.private_subnet_names["${count.index}"]
        ManagedBy = "${var.controller_name}"
  }
}