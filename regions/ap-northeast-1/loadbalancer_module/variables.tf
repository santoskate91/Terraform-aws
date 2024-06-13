# # terraform/regions/us-west-2/loadbalancer/variables.tf

variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/health"
}

variable "aws_security_group_load_balancer_security_group_id" {

}
variable "vpc_tokyo" {

}
variable "private_subnet_1_vpc_tokyo_id" {

}
variable "private_subnet_2_vpc_tokyo_id" {

}

# variable "aws_instance_bastion_list_id" {

# }
variable "aws_instance_webserver_list_id" {

}
