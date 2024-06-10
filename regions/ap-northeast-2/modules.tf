# terraform/regions/ap-northeast-2/modules.tf

# From child
module "vpc" {
  source = "./vpc_module"
}
