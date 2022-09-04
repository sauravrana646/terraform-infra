output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}

output "public_subnet_ids" {
  value = tolist(aws_subnet.tf_public_subnet[*])
}

output "private_subnet_ids" {
  value = tolist(aws_subnet.tf_private_subnet[*])
}