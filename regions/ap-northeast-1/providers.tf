# terraform/regions/ap-northeast-1/providers.tf

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  # alias  = "apnortheast1"
  region = var.region2

  access_key = var.access_key
  secret_key = var.secret_key
}
