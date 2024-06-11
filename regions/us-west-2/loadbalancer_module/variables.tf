# terraform/regions/us-west-2/loadbalancer/variables.tf

# ec2
# variable "ec2_instance_name" {
#   description = "value"
# }
# variable "aws_instance_bastion_list_id" {
#   description = "value"
# }
# variable "aws_instance_webserver_list_id" {
#   description = "value"
# }

variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/"
}

# security group
variable "aws_security_group_load_balancer_security_group_id" {
  description = "value"
}

# network vpc subnet
variable "vpc_vpc_1_id" {
  description = "value"
}
variable "vpc_public_subnet_1_vpc_1_id" {
  description = "value"
}
variable "vpc_public_subnet_2_vpc_1_id" {
  description = "value"
}

# variable "load_balancer_private" {

# }
variable "aws_instance_bastion_list_id" {

}
