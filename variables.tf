# terraform/variables.tf

# for provide region
variable "region1" {
  description = "The AWS region to create resources in."
  default     = "us-west-2"
}
variable "region2" {
  description = "The AWS region to create resources in."
  default     = "ap-northeast-1"
}
variable "region3" {
  description = "The AWS region to create resources in."
  default     = "ap-northeast-2"
}
variable "aws_access_key" {
  description = "AWS access key"
  default     = ""
}
variable "aws_secret_key" {
  description = "AWS secret key"
  default     = ""
}
# variable "ec2_instance_name" {
#   description = "Name of the EC2 instance"
#   default     = "terraform-lab"
# }

