resource "aws_api_gateway_domain_name" "github" {
  certificate_arn =  var.certificate_arn
  domain_name     =  var.fqdn
}

resource "aws_api_gateway_base_path_mapping" "github" {
  api_id      =  aws_api_gateway_rest_api.github.id
  stage_name  =  aws_api_gateway_deployment.github.stage_name
  domain_name =  aws_api_gateway_domain_name.github.domain_name
}

resource "aws_route53_record" "github" {
  name    =  aws_api_gateway_domain_name.github.domain_name
  type    = "A"
  zone_id =  var.route53_zone_id

  alias {
    evaluate_target_health = true
    name                   =  aws_api_gateway_domain_name.github.cloudfront_domain_name
    zone_id                =  aws_api_gateway_domain_name.github.cloudfront_zone_id
  }
}

resource "aws_route53_record" "github-ipv6" {
  name    =  aws_api_gateway_domain_name.github.domain_name
  type    = "AAAA"
  zone_id =  var.route53_zone_id

  alias {
    evaluate_target_health = true
    name                   =  aws_api_gateway_domain_name.github.cloudfront_domain_name
    zone_id                =  aws_api_gateway_domain_name.github.cloudfront_zone_id
  }
}
