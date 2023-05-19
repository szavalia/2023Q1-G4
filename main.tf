/**
module "api_gw" {
  source            = "./modules/api_gw"
  rest_api_desc     = "API gateway for the lambdas"
  rest_api_name     = "API-GW-G4"
  rest_api_tag_name = "API Gateway"
  #   TODO: Define lambda
  lambda_func_arn  = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:123456789012:function:dummy-lambda/invocations"
  lambda_func_name = "example-lambda"
}
*/

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "OAI for the static site"
}

/*
Esta seria la manera correcta (updateada de OAI) de dar permisos para acceder a S3,
por cuestión de tiempos y pruebas decidimos quedarnos con OAI
*/
#resource "aws_cloudfront_origin_access_control" "this" {
#  name                              = "S3 Access Control"
#  origin_access_control_origin_type = "s3"
#  signing_behavior                  = "always"
#  signing_protocol                  = "sigv4"
#}

module "acm" {
  source      = "./modules/acm"
  base_domain = var.base_domain
}


module "route53" {
  source      = "./modules/route53"
  base_domain = var.base_domain
  cdn         = module.cdn.cloudfront_distribution
}

module "cdn" {
  source          = "./modules/cdn"
  static_site     = module.web_site.domain_name
  OAI             = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
  certificate_arn = module.acm.certificate_arn
  alias           = [var.base_domain, "www.${var.base_domain}"]
}

module "web_site" {
  source            = "./modules/static_site"
  bucket_name       = "cloud-2023-1q-g4"
  bucket_access = [aws_cloudfront_origin_access_identity.this.iam_arn]
}


# TODO: move this to s3 module
resource "aws_s3_object" "data" {
  bucket = module.web_site.bucket_id
  key    = "index.html"
  source = "./index.html"
  content_type = "text/html"
}

module "vpc" { 
  source = "./modules/vpc"
  availability_zones = [ "us-east-1a", "us-east-1b" ]

  # These are the subnets that will be created IN EACH AZ
  public_subnet_count = 1
  private_subnet_count = 2
}