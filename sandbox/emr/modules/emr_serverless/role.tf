resource "aws_iam_role" "runtime" {
  name = "emr-serverless-example-runtime"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "emr-serverless.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "runtime" {
  role   = aws_iam_role.runtime.name
  policy = data.aws_iam_policy_document.runtime.json
}

data "aws_iam_policy_document" "runtime" {
  statement {
    actions = [
      "elasticmapreduce:GetClusterSessionCredentials",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "elasticmapreduce:ExecutionRoleArn"
      values   = var.studio_role_arns
    }
  }
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject*",
      "s3:DeleteObject",
    ]
    resources = [for b in var.buckets : "${b.arn}/${b.key}"]
  }
  statement {
    actions = [
      "s3:GetEncryptionConfiguration",
      "s3:ListBucket",
    ]
    resources = [for b in var.buckets : b.arn]
  }
}
