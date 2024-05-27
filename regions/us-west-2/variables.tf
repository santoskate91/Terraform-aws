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
