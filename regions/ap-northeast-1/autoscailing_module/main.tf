# # terraform/regions/ap-northeast-2/autoscailing_module/main.tf

# resource "aws_autoscaling_group" "ec2-ec2_cluster" {
#   name                 = "${var.ec2_instance_name}_auto_scaling_group"
#   min_size             = var.autoscale_min
#   max_size             = var.autoscale_max
#   desired_capacity     = var.autoscale_desired
#   health_check_type    = "EC2"
#   launch_configuration = var.aws_launch_configuration_ec2_name
#   vpc_zone_identifier  = [var.private_subnet_1_vpc_tokyo_id, var.private_subnet_2_vpc_tokyo_id]

#   # target_group_arns = [var.aws_alb_target_group_default_target_group_public_arn]
# }
