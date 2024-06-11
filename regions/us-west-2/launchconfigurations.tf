# terraform/regions/us-west-2/launchconfigurations.tf

# resource "aws_instance" "bastion" {
#   count                       = 2
#   ami                         = lookup(var.amis, var.region1)
#   instance_type               = var.instance_type
#   key_name                    = module.keypair.generated_key_keyname
#   iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
#   associate_public_ip_address = true
#   security_groups             = [aws_security_group.ec2_security_group.id]
#   subnet_id                   = count.index % 2 == 0 ? module.vpc.public_subnet_1_vpc_1_id : module.vpc.public_subnet_2_vpc_1_id
#   user_data                   = <<-EOL
#     #!/bin/bash  
#       sudo yum update -y
#       sudo yum install -y httpd
#       sudo systemctl start httpd
#       sudo systemctl enable httpd
#       echo "<h1>Hello World from $(hostname)</h1>" | sudo tee /var/www/html/index.html

#   EOL


#   tags = {
#     Name = "Bastion_${count.index + 1}_public"
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
#   depends_on = [module.keypair.generated_key_keyname]
# }

# resource "aws_instance" "webserver" {
#   count                       = 2
#   ami                         = lookup(var.amis, var.region1)
#   instance_type               = var.instance_type
#   key_name                    = module.keypair.generated_key_keyname
#   iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
#   associate_public_ip_address = false
#   security_groups             = [aws_security_group.ec2_security_group.id]
#   subnet_id                   = count.index % 2 == 0 ? module.vpc.private_subnet_1_vpc_1_id : module.vpc.private_subnet_2_vpc_1_id
#   user_data                   = <<-EOL
#     #!/bin/bash  
#       sudo yum update -y
#       sudo yum install -y httpd
#       sudo systemctl start httpd
#       sudo systemctl enable httpd
#       echo "<h1>Hello World from $(hostname)</h1>" | sudo tee /var/www/html/index.html
#   EOL
#   tags = {
#     Name = "webserver_${count.index + 1}_private"
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
#   depends_on = [module.keypair.generated_key_keyname]
# }

# # For auto scale
# resource "aws_launch_configuration" "ec2" {
#   name                        = "${var.ec2_instance_name}_instances_1c"
#   image_id                    = lookup(var.amis, var.region1)
#   instance_type               = var.instance_type
#   security_groups             = [aws_security_group.ec2_security_group.id]
#   key_name                    = module.keypair.generated_key_keyname
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
#   # depends_on = [module.vpc.natgw_vpc_1]
# }


# resource "aws_instance" "bastion2" {
#   ami                         = lookup(var.amis, var.region1)
#   instance_type               = var.instance_type
#   key_name                    = module.keypair.generated_key_keyname
#   iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
#   associate_public_ip_address = true
#   security_groups             = [aws_security_group.ec2_security_group_vpc_2.id]
#   subnet_id                   = module.vpc.public_subnet_1_vpc_2_id
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
#   depends_on = [module.keypair.generated_key_keyname]
# }
# resource "aws_instance" "webserver2" {
#   ami                         = lookup(var.amis, var.region1)
#   instance_type               = var.instance_type
#   key_name                    = module.keypair.generated_key_keyname
#   iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
#   associate_public_ip_address = false
#   security_groups             = [aws_security_group.ec2_security_group_vpc_2.id]
#   subnet_id                   = module.vpc.private_subnet_1_vpc_2_id
#   user_data                   = <<-EOL
#     #!/bin/bash  
#       sudo yum update -y
#       sudo yum install -y httpd
#       sudo systemctl start httpd
#       sudo systemctl enable httpd
#       echo "<h1>Hello World from $(hostname)</h1>" | sudo tee /var/www/html/index.html
#   EOL

#   tags = {
#     Name = "webserver_2_private"
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
#   depends_on = [module.keypair.generated_key_keyname]
# }

# resource "aws_cloudtrail" "us-west-2_cloudtrail" {
#   name                          = "us-west-2_cloudtrail"
#   s3_bucket_name                = var.trail_logs.bucket
#   s3_key_prefix                 = "cloudtrail/"
#   include_global_service_events = true
#   is_multi_region_trail         = true
#   enable_logging                = true

#   event_selector {
#     read_write_type           = "All"
#     include_management_events = true
#     data_resource {
#       type   = "AWS::S3::Object"
#       values = ["arn:aws:s3:::${var.trail_logs.bucket}/*"]
#     }
#   }

#   tags = {
#     Name = "us-west-2_cloudtrail"
#   }

#   depends_on = [
#     var.trail_logs
#   ]
# }
