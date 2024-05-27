# terraform/regions/us-west-2/launchconfigurations.tf

# data "aws_iam_policy_document" "ec2" {
#   statement {
#     actions = ["sts:AssumeRole"]
#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_policy" "session_manager" {
#   description = "session_manager"
#   name        = "session_manager"
#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Action" : "ec2:*",
#         "Effect" : "Allow",
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : "elasticloadbalancing:*",
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : "cloudwatch:*",
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : "autoscaling:*",
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : "iam:CreateServiceLinkedRole",
#         "Resource" : "*"
#         "Condition" : {
#           "StringEquals" : {
#             "iam:AWSServiceName" : [
#               "autoscaling.amazonaws.com",
#               "ec2scheduled.amazonaws.com",
#               "elasticloadbalancing.amazonaws.com",
#               "spot.amazonaws.com",
#               "spotfleet.amazonaws.com",
#               "transitgateway.amazonaws.com"
#             ]
#           }
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role" "session_manager" {
#   assume_role_policy = data.aws_iam_policy_document.ec2.json
#   name               = "session_manager"
#   tags = {
#     Name = "session_manager"
#   }
# }

# resource "aws_iam_instance_profile" "session_manager" {
#   name = "session_manager"
#   role = aws_iam_role.session_manager.name
# }

resource "aws_instance" "bastion" {
  count                       = 2
  ami                         = lookup(var.amis, var.region1)
  instance_type               = var.instance_type
  key_name                    = module.keypair.generated_key_keyname
  iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ec2_security_group.id]
  subnet_id                   = count.index % 2 == 0 ? module.vpc.public_subnet_1_vpc_1_id : module.vpc.public_subnet_2_vpc_1_id
  user_data                   = <<-EOL
    #!/bin/bash  
      sudo yum update -y
      sudo yum install -y httpd
      sudo systemctl start httpd
      sudo systemctl enable httpd
      echo "<h1>Hello World from $(hostname)</h1>" | sudo tee /var/www/html/index.html
  EOL

  tags = {
    Name = "Bastion_${count.index + 1}_public"
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [module.keypair.generated_key_keyname]
}

# resource "aws_instance" "webserver" {
#   count                       = 2
#   ami                         = lookup(var.amis, var.region)
#   instance_type               = var.instance_type
#   key_name                    = module.keypair.generated_key_keyname
#   iam_instance_profile        = aws_iam_instance_profile.session_manager.id
#   associate_public_ip_address = true
#   security_groups             = [aws_security_group.ec2_security_group.id]
#   subnet_id                   = count.index % 2 == 0 ? module.vpc.private_subnet_1_vp_1_id : module.vpc.private_subnet_2_vp_1_id
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

# For auto scale
resource "aws_launch_configuration" "ec2" {
  name                        = "${var.ec2_instance_name}_instances_1c"
  image_id                    = lookup(var.amis, var.region1)
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.ec2_security_group.id]
  key_name                    = module.keypair.generated_key_keyname
  iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
  associate_public_ip_address = false
  user_data                   = <<-EOL
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y httpd
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo "<h1>Hello World from $(hostname)</h1>" | sudo tee /var/www/html/index.html
  EOL
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [module.vpc.natgw_vpc_1]
}


resource "aws_instance" "bastion2" {
  ami                         = lookup(var.amis, var.region1)
  instance_type               = var.instance_type
  key_name                    = module.keypair.generated_key_keyname
  iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ec2_security_group_vpc_2.id]
  subnet_id                   = module.vpc.public_subnet_1_vpc_2_id
  user_data                   = <<-EOL
    #!/bin/bash  
      sudo yum update -y
      sudo yum install -y httpd
      sudo systemctl start httpd
      sudo systemctl enable httpd
      echo "<h1>Hello World from $(hostname)</h1>" | sudo tee /var/www/html/index.html
  EOL

  tags = {
    Name = "Bastion_2_public"
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [module.keypair.generated_key_keyname]
}
resource "aws_instance" "webserver2" {
  ami                         = lookup(var.amis, var.region1)
  instance_type               = var.instance_type
  key_name                    = module.keypair.generated_key_keyname
  iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ec2_security_group_vpc_2.id]
  subnet_id                   = module.vpc.private_subnet_1_vpc_2_id
  user_data                   = <<-EOL
    #!/bin/bash  
      sudo yum update -y
      sudo yum install -y httpd
      sudo systemctl start httpd
      sudo systemctl enable httpd
      echo "<h1>Hello World from $(hostname)</h1>" | sudo tee /var/www/html/index.html
  EOL

  tags = {
    Name = "webserver_2_private"
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [module.keypair.generated_key_keyname]
}
