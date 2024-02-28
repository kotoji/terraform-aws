module "redshift" {
  source = "./modules/redshift"

  identifier = "test20240229"

  admin_user_password = var.initial_admin_password
  default_dbname      = "sample"

  base_capacity = 8
  max_capacity  = 8

  publicly_accessible = true

  subnet_ids         = data.aws_subnets.use.ids
  security_group_ids = data.aws_security_groups.use.ids

  iam_roles = []
}
