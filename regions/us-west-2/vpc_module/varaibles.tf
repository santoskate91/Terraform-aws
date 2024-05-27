# terraform/regions/us-west-2/vpc_module/variables.tf

# networking

variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}
variable "public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.2.0/24"
}
variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24"
}
variable "private_subnet_2_cidr" {
  description = "CIDR Block for Private Subnet 2"
  default     = "10.0.4.0/24"
}
variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
}

variable "vpc_2_cidr" {
  description = "CIDR Block for VPC2"
  default     = "10.1.0.0/16"
}
variable "public_subnet_1_cidr_vpc_2" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.1.1.0/24"
}
variable "private_subnet_1_cidr_vpc_2" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.1.2.0/24"
}
