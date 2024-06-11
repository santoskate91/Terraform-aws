# terraform/modules.tf

# regions
module "us-west-2" {
  source                                      = "./regions/us-west-2"
  region1                                     = var.region1
  access_key                                  = var.aws_access_key
  secret_key                                  = var.aws_secret_key
  aws_iam_instance_profile_session_manager_id = aws_iam_instance_profile.session_manager.id

  tgw_ap-northeast-1_id                 = module.ap-northeast-1.tgw_ap-northeast-1_id
  tgw_ap-northeast-2_id                 = module.ap_northeast-2.tgw_ap-northeast-2_id
  vpc_cidr_ap-northeast-1               = module.ap-northeast-1.vpc_cidr_ap-northeast-1_cidr_blocks
  vpc_cidr_ap-northeast-2               = module.ap_northeast-2.vpc_cidr_ap-northeast-2_cidr_blocks
  peering_region_ap-northeast-1         = var.region2
  peering_region_ap-northeast-2         = var.region3
  tgw_ap-northeast-1_peering_attachment = module.ap-northeast-1.tgw_ap-northeast-1_peering_attachment
  tgw_ap-northeast-2_peering_attachment = module.ap_northeast-2.tgw_ap-northeast-2_peering_attachment

  # trail_logs = module.ap_northeast-2.trail_logs

  # load_balancer_private        = module.ap-northeast-1.load_balancer_private
  aws_instance_bastion_list_id = module.ap-northeast-1.aws_instance_bastion_list_id
}
module "ap-northeast-1" {
  source                                      = "./regions/ap-northeast-1"
  region2                                     = var.region2
  access_key                                  = var.aws_access_key
  secret_key                                  = var.aws_secret_key
  aws_iam_instance_profile_session_manager_id = aws_iam_instance_profile.session_manager.id

  vpc_cidr_us-west-2      = module.us-west-2.vpc_cidr_us-west-2_cidr_blocks
  vpc_cidr_ap-northeast-2 = module.ap_northeast-2.vpc_cidr_ap-northeast-2_cidr_blocks

  tgw_us-west-2_peering_attachment_id_1              = module.us-west-2.tgw_us-west-2_peering_attachment_id_1
  aws_security_group_load_balancer_security_group_id = module.us-west-2.aws_security_group_load_balancer_security_group_id

  trail_logs = module.ap_northeast-2.trail_logs
}
module "ap_northeast-2" {
  source                                      = "./regions/ap-northeast-2"
  region3                                     = var.region3
  access_key                                  = var.aws_access_key
  secret_key                                  = var.aws_secret_key
  aws_iam_instance_profile_session_manager_id = aws_iam_instance_profile.session_manager.id

  vpc_cidr_us-west-2                    = module.us-west-2.vpc_cidr_us-west-2_cidr_blocks
  vpc_cidr_ap-northeast-1               = module.ap-northeast-1.vpc_cidr_ap-northeast-1_cidr_blocks
  tgw_us-west-2_peering_attachment_id_2 = module.us-west-2.tgw_us-west-2_peering_attachment_id_2
}
