module "vpc" {
  source = "./modules/vpc"

  name = "default"
  cidr = "10.0.0.0/16"
  // 10.0.0.0/20   -> public
  // 10.0.64.0/20  -> (reserved)
  // 10.0.128.0/20 -> (reserved)
  // 10.0.192.0/20 -> (reserved)

  azs            = ["ap-northeast-1c", "ap-northeast-1d", "ap-northeast-1a"]
  public_subnets = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  public_subnet_tags = {
    subnet-type = "public"
  }
}

resource "aws_s3_bucket" "sandbox" {
  bucket = "ithnote-sandbox"
}

resource "aws_s3tables_table_bucket" "sandbox" {
  name = "ithnote-s3tables-sandbox"
}
