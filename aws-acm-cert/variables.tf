variable "cert_domain_name" {
  type        = "string"
  description = "Like www.foo.bar.com or *.foo.bar.com"
}

variable "cert_subject_alternative_names" {
  type        = "map"
  description = "A map of <alternative_domain:route53_zone_id>"
  default     = {}
}

variable "aws_route53_zone_id" {
  type = "string"
}

variable "project" {
  type = "string"
}

variable "env" {
  type = "string"
}

variable "service" {
  type = "string"
}

variable "owner" {
  type = "string"
}
