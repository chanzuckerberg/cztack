variable "cert_domain_name" {
  type        = string
  description = "Like www.foo.bar.com or *.foo.bar.com"
}

variable "cert_subject_alternative_names" {
  type        = map(string)
  description = "A map of <alternative_domain:route53_zone_id>"
  default     = {}
}

variable "aws_route53_zone_id" {
  type        = string
  description = "Default Route 53 zone to create validation records in"
}

variable "validation_record_ttl" {
  type        = string
  default     = 60
  description = "TTL value of DNS validation records"
}

variable "tags" {
  type        = object({ project : string, env : string, service : string, owner : string, managedBy : string })
  description = "Tags to apply to certificate"
}
