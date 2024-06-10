# terraform/regions/ap-northeast-2/provides.tf

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  # alias  = "uswest2"
  region = var.region3

  access_key = var.access_key
  secret_key = var.secret_key
}
