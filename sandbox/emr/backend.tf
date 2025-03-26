terraform {
  cloud {
    organization = "ithnote"

    workspaces {
      name = "sandbox-emr"
    }
  }

  required_version = ">= 1.10.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.83.0"
    }
  }
}
