variable "base_domain" {
  description = "Base domain of the application. This variable should be set to a subdomain of an existing domain."
  type        = string
}

variable "cdn" {
  description = "Cloudfront distribution to be aliased."
  type = object({
    domain_name    = string
    hosted_zone_id = string
  })
}