terraform {
  cloud {
    organization = "kotojpn"

    workspaces {
      name = "network"
    }
  }

  required_version = ">= 1.3.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.50.0"
    }
  }
}
