# terraform/autoscailing_module/variables.tf

# auto scaling
variable "autoscale_min" {
  description = "Minimum autoscale (number of EC2)"
  default     = "2"
}
variable "autoscale_max" {
  description = "Maximum autoscale (number of EC2)"
  default     = "2"
}
variable "autoscale_desired" {
  description = "Desired autoscale (number of EC2)"
  default     = "2"
}

variable "ec2_instance_name" {
  description = "var from main module"
}
variable "aws_launch_configuration_ec2_name" {
  description = "var from main module"
}
# variable "aws_alb_target_group_default_target_group_public_arn" {
#   description = "var from main module"
# }

variable "private_subnet_1_vp_1_id" {
  description = "var from main module"
}
variable "private_subnet_2_vp_1_id" {
  description = "var from main module"
}
