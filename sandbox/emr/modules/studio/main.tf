module "emr_studio" {
  source  = "terraform-aws-modules/emr/aws//modules/studio"
  version = "2.4.0"

  create = var.create

  name                        = var.name
  auth_mode                   = "IAM"
  default_s3_location         = length(var.default_bucket.dir) > 1 ? "s3://${var.default_bucket.bucket}/${var.default_bucket.dir}" : "s3://${var.default_bucket.bucket}"
  service_role_s3_bucket_arns = flatten([for bucket in var.buckets : [bucket.arn, "${bucket.arn}/${bucket.key}"]])
  user_role_s3_bucket_arns    = flatten([for bucket in var.buckets : [bucket.arn, "${bucket.arn}/${bucket.key}"]])

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
}
