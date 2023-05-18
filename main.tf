module "api-gw" {
  source            = "./modules/api-gw"
  rest_api_desc     = "API gateway for the lambdas"
  rest_api_name     = "API-GW-G4"
  rest_api_tag_name = "API Gateway"
  #   TODO: Define lambda
  lambda_func_arn  = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:123456789012:function:dummy-lambda/invocations"
  lambda_func_name = "example-lambda"
}

module "web_site" {
  source      = "./modules/static_site"
  bucket_name = "cloud-2023-1q-g4"
}

module "cdn" {
  source      = "./modules/cdn"
  static_site = module.web_site.domain_name
}

resource "aws_s3_object" "data" {
  bucket = module.web_site.bucket_id
  key    = "index.html"
  source = "./index.html"
  #etag         = filemd5("${var.src}/${each.value.file}")
  #content_type = each.value.mime
}
