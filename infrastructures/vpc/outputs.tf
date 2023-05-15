output "vpc_id" {
  value = aws_vpc.main.id
}

output "security_group_default" {
  value = aws_default_security_group.this.id
}

output "subnets_public" {
  value = values(aws_subnet.public)[*].id
}

output "subnets_private" {
  value = values(aws_subnet.private)[*].id
}

