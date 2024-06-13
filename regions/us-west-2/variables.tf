# terraform/regions/us-west-2/variables.tf

variable "region1" {
  description = "from root"
}
variable "access_key" {
  description = "from root"
}
variable "secret_key" {
  description = "from root"
}

variable "aws_iam_instance_profile_session_manager_id" {
  description = "from root"
}

variable "amis" {
  description = "Which AMI to spawn."
  default = {
    us-west-2 = "ami-01cd4de4363ab6ee8"
  }
}
variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  default     = "terraform-lab-us-west-2"
}

# transit
variable "tgw_ap-northeast-1_id" {

}
variable "tgw_ap-northeast-2_id" {

}
variable "vpc_cidr_ap-northeast-1" {

}
variable "vpc_cidr_ap-northeast-2" {

}
variable "peering_region_ap-northeast-1" {

}
variable "peering_region_ap-northeast-2" {

}
variable "tgw_ap-northeast-1_peering_attachment" {

}
variable "tgw_ap-northeast-2_peering_attachment" {

}
variable "load_balancer_private_dns_name" {

}
variable "aws_instance_bastion_list_id" {

}
