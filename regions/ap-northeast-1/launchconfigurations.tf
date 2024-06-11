# terraform/regions/ap-northeast-1/launchconfigurations.tf

# # For auto scale
# resource "aws_launch_configuration" "ec2" {
#   name                        = "${var.ec2_instance_name}_instances_1c"
#   image_id                    = lookup(var.amis, var.region2)
#   instance_type               = var.instance_type
#   security_groups             = [aws_security_group.ec2_security_group_tokyo.id]
#   key_name                    = module.keypair.generated_key_tokyo_keyname
#   iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
#   associate_public_ip_address = false
#   user_data                   = <<-EOL
#   #!/bin/bash
#   sudo yum update -y
#   sudo yum install -y httpd
#   sudo systemctl start httpd
#   sudo systemctl enable httpd
#   echo "<h1>Hello World from $(hostname)</h1>" | sudo tee /var/www/html/index.html

#   EOL

#   lifecycle {
#     create_before_destroy = true
#   }
#   depends_on = [module.keypair.generated_key_tokyo_keyname]

# }
resource "aws_instance" "webserver" {
  count                       = 2
  ami                         = lookup(var.amis, var.region2)
  instance_type               = var.instance_type
  key_name                    = module.keypair.generated_key_tokyo_keyname
  iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
  associate_public_ip_address = false
  security_groups             = [aws_security_group.ec2_security_group_tokyo.id]
  subnet_id                   = count.index % 2 == 0 ? module.vpc.private_subnet_1_vpc_tokyo_id : module.vpc.private_subnet_2_vpc_tokyo_id
  user_data                   = <<-EOL
    #!/bin/bash  
      sudo yum update -y
      sudo yum install -y httpd
      sudo systemctl start httpd
      sudo systemctl enable httpd
      echo "<h1>Hello World from $(hostname)</h1>" | sudo tee /var/www/html/index.html
  EOL
  tags = {
    Name = "webserver_${count.index + 1}_private"
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [module.keypair.generated_key_tokyo_keyname]
}

# resource "aws_instance" "bastion2" {
#   ami                         = lookup(var.amis, var.region2)
#   instance_type               = var.instance_type
#   key_name                    = module.keypair.generated_key_tokyo_keyname
#   iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
#   associate_public_ip_address = true
#   security_groups             = [aws_security_group.ec2_security_group_tokyo.id]
#   subnet_id                   = module.vpc.public_subnet_1_vpc_tokyo
#   user_data                   = <<-EOL
#     #!/bin/bash  
#       sudo yum update -y
#       sudo yum install -y httpd
#       sudo systemctl start httpd
#       sudo systemctl enable httpd
#       echo "<h1>Hello World from $(hostname)</h1>" | sudo tee /var/www/html/index.html
#   EOL

#   tags = {
#     Name = "Bastion_2_public_vpc_2"
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
#   depends_on = [module.keypair.generated_key_tokyo_keyname]
# }
