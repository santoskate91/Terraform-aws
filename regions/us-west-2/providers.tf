# terraform/regions/us-west-2/providers.tf

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  # alias  = "uswest2"
  region = var.region1

  access_key = var.access_key
  secret_key = var.secret_key
}
