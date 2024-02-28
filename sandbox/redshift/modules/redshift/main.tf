resource "aws_redshiftserverless_namespace" "this" {
  namespace_name = var.identifier

  admin_username      = "admin"
  admin_user_password = var.admin_user_password
  db_name             = var.default_dbname

  iam_roles = var.iam_roles
}

resource "aws_redshiftserverless_workgroup" "this" {
  workgroup_name = var.identifier
  namespace_name = aws_redshiftserverless_namespace.this.namespace_name

  base_capacity = var.base_capacity
  max_capacity  = var.max_capacity

  publicly_accessible = var.publicly_accessible

  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
}
