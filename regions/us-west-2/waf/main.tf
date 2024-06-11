# resource "aws_wafv2_ip_set" "waf_ip_set" { //ip set สำหรับจะบล็อกหรืออนุญาตให้เข้าเว็บ
#   name               = "waf_ip_set"
#   description        = "WAF IP set for "
#   scope              = "REGIONAL"
#   ip_address_version = "IPV4"
#   addresses          = ["125.26.202.17/32"] //block public ip only
#   tags = {
#     Name = "waf_ip_set"
#     # Tag2 = "Value2"
#   }
# }

# resource "aws_wafv2_web_acl" "web_acl_waf" {
#   name        = "web_acl_waf"
#   description = "Managed rule WAF"
#   scope       = "REGIONAL"

#   default_action { //ให้อนุญาตให้ request ทั้งหมดที่ไม่ตรงกับกฎที่กำหนดไว้ใน Web ACL
#     allow {}
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesCommonRuleSet"
#     priority = 0  // 0 = สำคัญสุด
#     override_action {
#       none {} //ไม่มีการแทนที่การกระทำใด ๆ ที่ทำไว้อยู่ก่อน
#     }
#     statement { // คำสั่งที่ใช้ในการกำหนดเงื่อนไขหรือรายละเอียดของกฎ
#       managed_rule_group_statement { 
#         name        = "AWSManagedRulesCommonRuleSet"  //ไว้ป้องกันพวกโจมตีต่างๆ เช่น xss, sqli, ช่องโหว่
#         vendor_name = "AWS"
#         rule_action_override {
#           action_to_use {
#             allow {}
#           }
#           name = "SizeRestrictions_BODY"
#         }
#       }
#     }
#     visibility_config { // กำหนดการตั้งค่าเพื่อติดตามและบันทึก metric ของกฎนี้
#       cloudwatch_metrics_enabled = true //เปิดใช้งานการติดตาม cloudwatch metrics
#       metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesAmazonIpReputationList"
#     priority = 1

#     override_action {
#       none {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWSManagedRulesAmazonIpReputationList" //ใช้จำกัดการเข้าถึงหรือเล็อกการเชื่อมต่อจาก ip ad 
#         vendor_name = "AWS"
#       }
#     }
#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "AWS-AWSManagedRulesAmazonIpReputationList"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesSQLiRuleSet"
#     priority = 2

#     override_action {
#       none {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWSManagedRulesSQLiRuleSet"
#         vendor_name = "AWS"
#       }
#     }
#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
#       sampled_requests_enabled   = true
#     }
#   }

#   visibility_config {
#     cloudwatch_metrics_enabled = true
#     metric_name                = "WafMetrics"
#     sampled_requests_enabled   = true
#   }
# }

# resource "aws_wafv2_web_acl_association" "example_association" {
#   resource_arn = aws_lb.my_lb.arn
#   web_acl_arn  = aws_wafv2_web_acl.example.arn
# }
