variable "cdn_tag_name" {
  type        = string
  description = "Cloudfront tag for CDN"
}

variable "origin" {
    description = "Origin for distribution"
    type        = any
    default     = null
}

variable "origin_path" {
    description = "Origin path for distribution"
    type        = string
    default     = ""
}

variable "logging_config" {
    description = "Logging configuration"
    type        = any
    default     = {}
}

variable "default_cache_behavior" {
    description = "Cache behavior configuration"
    type        = any
    default     = null
}

variable "geo_restriction" {
    description = "Restriction configuration"
    type        = any
    default     = {}
}

variable "viewer_certificate" {
    description = "SSL configuration"
    type        = any
    default     = {
        cloudfront_default_certificate  = true
        minimum_protocol_version        = "TLSv1.2_2018"
    }
}