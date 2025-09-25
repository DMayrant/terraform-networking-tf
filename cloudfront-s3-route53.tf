resource "aws_cloudfront_vpc_origin" "alb" {
  vpc_origin_endpoint_config {
    name                   = "example-vpc-origin"
    arn                    = aws_lb.app_lb.arn
    http_port              = 80
    https_port             = 443
    origin_protocol_policy = "https-only"

    origin_ssl_protocols {
      items    = ["TLSv1.2"]
      quantity = 1

    }
  }
}

resource "aws_s3_bucket" "disaster" {
  bucket              = "disaster-recovery-bucket9997"
  object_lock_enabled = true
  force_destroy       = false

  tags = merge(local.common_tags, {
    Name = "DR-bucket"
  })


}

data "aws_route53_zone" "hosted_zone" {
  name = var.domain_name #register a domain name 
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.hosted_zone.id
  name    = var.record_name
  type    = "A"

  alias { # the alias switches traffic from ALB to our Domain name
    name                   = aws_lb.app_lb.dns_name
    zone_id                = aws_lb.app_lb.zone_id
    evaluate_target_health = true

  }
}




