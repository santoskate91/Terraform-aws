# terraform/regions/ap-northeast-1/variables.tf

variable "region2" {
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
    ap-northeast-1 = "ami-02a405b3302affc24"
  }
}
variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  default     = "terraform-lab-ap-northeast-1"
}

variable "tgw_u-west-2_id" {

}
variable "vpc_cidr_us-west-2" {

}
# variable "peering_region_us-west-2" {

# }
variable "tgw_us-west-2_peering_attachment_id" {

}
