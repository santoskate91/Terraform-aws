# terraform/regions/ap-northeast-2/variables.tf

variable "region3" {
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
    ap-northeast-2 = "ami-0b8414ae0d8d8b4cc"
  }
}
variable "instance_type" {
  default = "t3.micro"
}

variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  default     = "terraform-lab-ap-northeast-2"
}
variable "vpc_cidr_us-west-2" {

}
variable "tgw_us-west-2_peering_attachment_id_2" {

}
variable "vpc_cidr_ap-northeast-1" {

}
