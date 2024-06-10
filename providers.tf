# terraform/providers.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  # alias      = "uswest2"
  region     = var.region1
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  alias      = "apnortheast1"
  region     = var.region2
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  alias      = "apnortheast2"
  region     = var.region3
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

