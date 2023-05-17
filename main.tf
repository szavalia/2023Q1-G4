module "web_site" {
  source      = "./modules/static_site"
  bucket_name = "cloud-2023-1q-g4"
}

resource "aws_s3_object" "data" {
  bucket = module.web_site.bucket_id
  key    = "index.html"
  source = "./index.html"
  #etag         = filemd5("${var.src}/${each.value.file}")
  #content_type = each.value.mime
}

module "cloudfront" {
  source       = "./modules/cloudfront"
  cdn_tag_name = "Cloudfront"
  #depends_on   = [module.api-gw]

  origin = {
    # api-gw = {
    #   domain_name = replace(replace(module.api-gw.rest_api_domain_name, "https://", ""), "/", "")
    #   origin_path = module.api-gw.rest_api_path
    #   custom_origin_config = {
    #     http_port              = 80
    #     https_port             = 443
    #     origin_protocol_policy = "match-viewer"
    #     origin_ssl_protocols   = ["TLSv1.2"]
    #   }
    # }

    # #TODO: Add s3 bucket 
    s3_bucket = {
      domain_name = "module.web_site.website_endpoint"
      origin_path = ""
      origin_id   = "module.web_site.bucket_id"
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  default_cache_behavior = {
    target_origin_id = "s3_bucket"
  }
}