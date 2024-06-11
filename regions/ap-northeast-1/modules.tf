# terraform/regions/ap-northeast-1/modules.tf

# From child
module "vpc" {
  source = "./vpc_module"
}
module "keypair" {
  source = "./keypair_module"
}
# module "autoscaling" {
#   source = "./autoscailing_module"

#   ec2_instance_name                 = var.ec2_instance_name
#   aws_launch_configuration_ec2_name = aws_launch_configuration.ec2.name
#   # aws_alb_target_group_default_target_group_public_arn = module.loadbalancer.aws_alb_target_group_default_target_group_public_arn
#   private_subnet_1_vpc_tokyo_id = module.vpc.private_subnet_1_vpc_tokyo_id
#   private_subnet_2_vpc_tokyo_id = module.vpc.private_subnet_2_vpc_tokyo_id
# }
# module "loadbalancer" {
#   source = "./loadbalancer_module"

#   aws_security_group_load_balancer_security_group_id = aws_security_group.load_balancer_security_group.id
#   vpc_tokyo                                          = module.vpc.vpc_tokyo
#   private_subnet_1_vpc_tokyo_id                      = module.vpc.private_subnet_1_vpc_tokyo_id
#   private_subnet_2_vpc_tokyo_id                      = module.vpc.private_subnet_2_vpc_tokyo_id
#   aws_instance_bastion_list_id                       = aws_instance.webserver[*].id
#   aws_instance_webserver_list_id                     = aws_launch_configuration.ec2[*].id
# }
