output "bucket_id" {
    description = "Id of the created bucket"
    value = module.static_site.s3_bucket_id
}

output "website_endpoint" {
  description = "The website endpoint, if the bucket is configured with a website. If not, this will be an empty string"
  value       = module.static_site.s3_bucket_website_endpoint
}