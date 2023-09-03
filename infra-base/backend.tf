terraform {
  cloud {
    organization = "kotojpn"

    workspaces {
      name = "infra-base"
    }
  }

  required_version = ">= 1.5.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15.0"
    }
  }
}
