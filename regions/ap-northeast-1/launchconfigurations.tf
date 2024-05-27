# terraform/regions/ap-northeast-1/launchconfigurations.tf

resource "aws_instance" "bastion2" {
  ami                         = lookup(var.amis, var.region2)
  instance_type               = var.instance_type
  key_name                    = module.keypair.generated_key_keyname
  iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ec2_security_group_tokyo.id]
  subnet_id                   = module.vpc.public_subnet_1_vpc_tokyo
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
  ami                         = lookup(var.amis, var.region2)
  instance_type               = var.instance_type
  key_name                    = module.keypair.generated_key_keyname
  iam_instance_profile        = var.aws_iam_instance_profile_session_manager_id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ec2_security_group_tokyo.id]
  subnet_id                   = module.vpc.private_subnet_1_vpc_tokyo
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
