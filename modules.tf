# terraform/modules.tf

# regions
module "us-west-2" {
  source                                      = "./regions/us-west-2"
  region1                                     = var.region1
  access_key                                  = var.aws_access_key
  secret_key                                  = var.aws_secret_key
  aws_iam_instance_profile_session_manager_id = aws_iam_instance_profile.session_manager.id
  tgw_ap-northeast-1_id                       = module.ap-northeast-1.tgw_ap-northeast-1_id
  vpc_cidr_ap-northeast-1                     = module.ap-northeast-1.vpc_cidr_ap-northeast-1_cidr_blocks
  peering_region_ap-northeast-1               = var.region2
  tgw_ap-northeast-1_peering_attachment       = module.ap-northeast-1.tgw_ap-northeast-1_peering_attachment
}
module "ap-northeast-1" {
  source                                      = "./regions/ap-northeast-1"
  region2                                     = var.region2
  access_key                                  = var.aws_access_key
  secret_key                                  = var.aws_secret_key
  aws_iam_instance_profile_session_manager_id = aws_iam_instance_profile.session_manager.id
  tgw_u-west-2_id                             = module.us-west-2.tgw_u-west-2_id
  vpc_cidr_us-west-2                          = module.us-west-2.vpc_cidr_us-west-2_cidr_blocks
  # peering_region_us-west-2                    = var.region1
  tgw_us-west-2_peering_attachment_id = module.us-west-2.tgw_us-west-2_peering_attachment_id
}
