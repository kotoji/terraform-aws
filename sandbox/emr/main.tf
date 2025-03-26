module "glue" {
  source = "./modules/glue"
}

resource "aws_s3_bucket" "example" {
  bucket        = "ithnote-emr-example"
  force_destroy = true
}

resource "aws_s3_object" "studio" {
  bucket       = aws_s3_bucket.example.bucket
  key          = "studio/"
  content_type = "application/x-directory"
}

resource "aws_s3tables_table" "example" {
  name             = "example_table"
  namespace        = aws_s3tables_namespace.example.namespace
  table_bucket_arn = aws_s3tables_namespace.example.table_bucket_arn
  format           = "ICEBERG"
}

resource "aws_s3tables_namespace" "example" {
  namespace        = "example_namespace"
  table_bucket_arn = aws_s3tables_table_bucket.example.arn
}

resource "aws_s3tables_table_bucket" "example" {
  name = "ktj-iceberg-example"
}

module "studio" {
  source = "./modules/studio"

  name = "emr-studio-example"

  default_bucket = {
    bucket = aws_s3_bucket.example.bucket
    arn    = aws_s3_bucket.example.arn
    dir    = aws_s3_object.studio.key
  }
  buckets = [
    {
      arn = aws_s3_bucket.example.arn
      key = "${aws_s3_object.studio.key}*"
    },
    {
      arn = aws_s3tables_table_bucket.example.arn
      key = "*"
    },
    {
      arn = "arn:aws:s3tables:ap-northeast-1:066320025717:bucket/ithnote-s3tables-sandbox"
      # e.g. "table/5c4abd1b-4554-4f82-a53f-c29d6c42bbc5/*"
      key = "*"
    },
    {
      arn = "arn:aws:s3:::ithnote-sandbox"
      key = "*"
    },
  ]

  vpc_id     = data.aws_vpc.default.id
  subnet_ids = [data.aws_subnets.use.ids[0]]
}

module "emr_serverless" {
  source = "./modules/emr_serverless"

  name = "emr-serverless-example"

  buckets = [
    {
      arn = aws_s3_bucket.example.arn
      key = "${aws_s3_object.studio.key}*"
    },
    {
      arn = aws_s3tables_table_bucket.example.arn
      key = "*"
    },
    {
      arn = "arn:aws:s3tables:ap-northeast-1:066320025717:bucket/ithnote-s3tables-sandbox"
      # e.g. "table/5c4abd1b-4554-4f82-a53f-c29d6c42bbc5/*"
      key = "*"
    },
    {
      arn = "arn:aws:s3:::ithnote-sandbox"
      key = "*"
    },
  ]
  studio_role_arns = [
    "arn:aws:iam::066320025717:user/kotoji@admin"
  ]
  subnet_ids = [data.aws_subnets.use.ids[0]]
}
