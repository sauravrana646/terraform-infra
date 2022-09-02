output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}

output "subnet_ids" {
  value = tolist(aws_subnet.tf_public_subnet[*])
}

output "subnet" {
  value = aws_subnet.tf_public_subnet
}