terraform {
  cloud {
    organization = "ithnote"

    workspaces {
      name = "sandbox-redshift"
    }
  }

  required_version = ">= 1.7.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.38.0"
    }
  }
}
