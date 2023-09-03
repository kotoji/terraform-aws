output "vpc_id" {
  value = module.vpc.vpc_id
}

output "default_security_group_id" {
  value = module.vpc.default_security_group_id
}

output "igw_id" {
  value = module.vpc.igw_id
}

output "igw_arn" {
  value = module.vpc.igw_arn
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "public_subnet_arns" {
  value = module.vpc.public_subnet_arns
}

