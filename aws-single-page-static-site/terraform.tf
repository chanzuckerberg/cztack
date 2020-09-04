terraform {
  required_providers {
    # Depends on aws_route53_zone.zone.name not returning trailing "." starting in 3.0.0
    aws = ">= 3.0.0"
  }
}
