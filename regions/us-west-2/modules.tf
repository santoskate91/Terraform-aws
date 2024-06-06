# terraform/regions/us-west-2/modules.tf

# From child
module "vpc" {
  source = "./vpc_module"
}
module "keypair" {
  source = "./keypair_module"
}

# To child
# autoscaling
module "autoscaling" {
  source = "./autoscailing_module"

  ec2_instance_name                 = var.ec2_instance_name
  aws_launch_configuration_ec2_name = aws_launch_configuration.ec2.name
  # aws_alb_target_group_default_target_group_public_arn = module.loadbalancer.aws_alb_target_group_default_target_group_public_arn
  private_subnet_1_vpc_1_id = module.vpc.private_subnet_1_vpc_1_id
  private_subnet_2_vpc_1_id = module.vpc.private_subnet_2_vpc_1_id
}
# # loadbalancer
# module "loadbalancer" {
#   source = "./loadbalancer_module"

#   ec2_instance_name                                  = var.ec2_instance_name
#   aws_security_group_load_balancer_security_group_id = aws_security_group.load_balancer_security_group.id
#   vpc_vpc_1_id                                       = module.vpc.vpc_1_id
#   vpc_public_subnet_1_vpc_1_id                       = module.vpc.public_subnet_1_vpc_1_id
#   vpc_public_subnet_2_vpc_1_id                       = module.vpc.public_subnet_2_vpc_1_id
#   aws_instance_bastion_list_id                       = aws_instance.bastion[*].id
#   # aws_instance_webserver_list_id                     = aws_instance.webserver[*].id
# }
# # cloudfront
# module "cloudfront" {
#   source = "./cloudfront_module"

#   loadbalancer_aws_lb_load_balancer_public_dns_name = module.loadbalancer.aws_lb_load_balancer_public_dns_name
# }
