# terraform/regions/ap-northeast-1/modules.tf

# From child
module "vpc" {
  source = "./vpc_module"
}
module "keypair" {
  source = "./keypair_module"
}
