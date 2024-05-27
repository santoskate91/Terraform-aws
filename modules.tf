# terraform/modules.tf

# regions
module "us-west-2" {
  source                                      = "./regions/us-west-2"
  region1                                     = var.region1
  access_key                                  = var.aws_access_key
  secret_key                                  = var.aws_secret_key
  aws_iam_instance_profile_session_manager_id = aws_iam_instance_profile.session_manager.id
}
module "ap-northeast-1" {
  source                                      = "./regions/ap-northeast-1"
  region2                                     = var.region2
  access_key                                  = var.aws_access_key
  secret_key                                  = var.aws_secret_key
  aws_iam_instance_profile_session_manager_id = aws_iam_instance_profile.session_manager.id
}
