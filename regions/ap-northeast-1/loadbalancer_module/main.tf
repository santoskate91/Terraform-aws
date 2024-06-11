# # terraform/regions/us-west-2/loadbalancer/loadbalancer.tf

# # Internal Load Balancer in Tokyo
# resource "aws_lb" "load_balancer_private" {
#   name               = "loanbalancer-internal-lb-ap1"
#   internal           = true
#   load_balancer_type = "application"
#   security_groups    = [var.aws_security_group_load_balancer_security_group_id]
#   subnets            = [var.private_subnet_1_vpc_tokyo_id, var.private_subnet_2_vpc_tokyo_id]
# }

# resource "aws_lb_target_group" "internal_app_targets_tokyo" {
#   name     = "internal-app-targets-tokyo"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = var.vpc_tokyo
# }

# resource "aws_lb_listener" "internal_listener" {
#   load_balancer_arn = aws_lb.load_balancer_private.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.internal_app_targets_tokyo.arn
#   }
# }

# # ALB attachment
# resource "aws_alb_target_group_attachment" "bastion_attachment_public" {
#   for_each         = { for idx, id in var.aws_instance_bastion_list_id : idx => id }
#   target_group_arn = aws_lb_target_group.internal_app_targets_tokyo.arn
#   target_id        = each.value
#   port             = 80
# }

# resource "aws_alb_target_group_attachment" "webserver_attachment_public" {
#   for_each         = { for idx, id in var.aws_instance_webserver_list_id : idx => id }
#   target_group_arn = aws_lb_target_group.internal_app_targets_tokyo.arn
#   target_id        = each.value
#   port             = 80
# }
