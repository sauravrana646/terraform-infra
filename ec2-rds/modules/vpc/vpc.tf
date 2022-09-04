data "aws_availability_zones" "vpc_az" {
  state = "available"
}


resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_ipv4_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name      = "${var.main_name}-vpc"
    ManagedBy = "${var.controller_name}"
  }
}

resource "aws_subnet" "tf_public_subnet" {
  depends_on = [
    aws_vpc.tf_vpc
  ]
  /* for_each = toset(var.public_subnet_names) */
  vpc_id = aws_vpc.tf_vpc.id
  /* cidr_block = var.aws_public_subnet_cidr["${count.index}"] */
  cidr_block        = cidrsubnet(var.vpc_ipv4_cidr, 8, "${count.index}")
  availability_zone = data.aws_availability_zones.vpc_az.names[count.index % length(data.aws_availability_zones.vpc_az.names)]
  count             = var.public_subnet_count
  tags = {
    Name      = join("-", ["${var.main_name}-public-subnet", "${count.index}", tostring(data.aws_availability_zones.vpc_az.names[count.index % length(data.aws_availability_zones.vpc_az.names)])])
    ManagedBy = "${var.controller_name}"
  }
}

resource "aws_subnet" "tf_private_subnet" {
  depends_on = [
    aws_vpc.tf_vpc
  ]
  /* for_each = toset(var.private_subnet_names) */
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = cidrsubnet(var.vpc_ipv4_cidr, 8, tostring(sum([var.public_subnet_count, "${count.index}"])))
  availability_zone = data.aws_availability_zones.vpc_az.names[count.index % length(data.aws_availability_zones.vpc_az.names)]
  # cidr_block = var.aws_private_subnet_cidr["${count.index}"]
  count = var.private_subnet_count
  tags = {
    Name      = join("-", ["${var.main_name}-private-subnet", "${count.index}", tostring(data.aws_availability_zones.vpc_az.names[count.index % length(data.aws_availability_zones.vpc_az.names)])])
    ManagedBy = "${var.controller_name}"
  }
}

resource "aws_internet_gateway" "tf_igw" {
  depends_on = [
    aws_vpc.tf_vpc
  ]
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name      = join("-", [var.main_name, "igw"])
    ManagedBy = var.controller_name
  }
}

resource "aws_route_table" "tf_public_route_table" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }
  tags = {
    Name      = join("-", [var.main_name, "public-route-table"])
    ManagedBy = var.controller_name
  }
}

resource "aws_route_table" "tf_private_route_table" {
  vpc_id = aws_vpc.tf_vpc.id

  route = []
  tags = {
    Name      = join("-", [var.main_name, "private-route-table"])
    ManagedBy = var.controller_name
  }
}

resource "aws_route_table_association" "tf_public_rt_association" {
  subnet_id      = aws_subnet.tf_public_subnet[count.index].id
  route_table_id = aws_route_table.tf_public_route_table.id
  count          = var.public_subnet_count
}

resource "aws_route_table_association" "tf_private_rt_association" {
  subnet_id      = aws_subnet.tf_private_subnet[count.index].id
  route_table_id = aws_route_table.tf_private_route_table.id
  count          = var.private_subnet_count
}
