data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}

data "aws_subnets" "use" {
  filter {
    name   = "tag:subnet-type"
    values = ["public"]
  }
}
