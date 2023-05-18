resource "aws_cloudfront_origin_access_identity" "this" {
    comment = var.static_site
}

# TODO: Solo cloudfront puede acceder a S3
resource "aws_cloudfront_distribution" "this" {
    enabled = true

    origin {
        domain_name = var.static_site
        origin_id = var.static_site
        
        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path            
        }
    }

    default_root_object = "index.html"

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = var.static_site

        forwarded_values { # TODO: esto esta deprecado, deberiamos cambiar a cache_policy_id
            query_string = false

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "allow-all"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      #   locations        = ["US", "CA", "GB", "DE", "IN", "IR"]
    }
  }

  viewer_certificate {
        cloudfront_default_certificate = true
        #acm_certificate_arn             = lookup(var.viewer_certificate, "acm_certificate_arn", null)
        #cloudfront_default_certificate  = lookup(var.viewer_certificate, "cloudfront_default_certificate", null)
        #iam_certificate_id              = lookup(var.viewer_certificate, "iam_certificate_id", null)
        #minimum_protocol_version        = lookup(var.viewer_certificate, "minimum_protocol_version", "TLSv1.2_2018")
        #ssl_support_method              = lookup(var.viewer_certificate, "ssl_support_method", null)
    }
}