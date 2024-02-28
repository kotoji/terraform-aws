module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.name
  cidr = var.cidr

  azs                     = var.azs
  public_subnets          = var.public_subnets
  public_subnet_tags      = var.public_subnet_tags
  map_public_ip_on_launch = false

  // unnecessary
  enable_nat_gateway     = false
  enable_vpn_gateway     = false
  create_egress_only_igw = false

  // YAGNI
  create_database_subnet_group    = false
  create_elasticache_subnet_group = false
  create_redshift_subnet_group    = false

  tags = var.tags
}
