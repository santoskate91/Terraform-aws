# # terraform/regions/us-west-2/cloudfront_module/main.tf

# resource "aws_cloudfront_distribution" "cf_alb" {
#   origin {
#     domain_name = var.loadbalancer_aws_lb_load_balancer_public_dns_name
#     origin_id   = "Custom-ALB-Origin"
#     custom_origin_config {
#       http_port  = 80
#       https_port = 443
#       # สามารถเปลี่ยนเป็น "match-viewer" หากต้องการให้ CloudFront ใช้โปรโตคอลที่คล้ายกับคำขอมาจาก Viewer
#       origin_protocol_policy = "http-only"
#       origin_ssl_protocols   = ["TLSv1.2"]
#     }
#   }

#   enabled             = true
#   default_root_object = "index.html"

#   default_cache_behavior {
#     target_origin_id       = "Custom-ALB-Origin"
#     viewer_protocol_policy = "redirect-to-https"
#     allowed_methods        = ["GET", "HEAD", "OPTIONS"]
#     cached_methods         = ["GET", "HEAD", "OPTIONS"]
#     forwarded_values {
#       query_string = false
#       cookies {
#         forward = "none"
#       }
#     }
#     min_ttl     = 0
#     default_ttl = 0 # 3600
#     max_ttl     = 0 # 86400
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
# }
