data "aws_iam_policy_document" "www" {
	statement {
		actions   = ["s3:GetObject"]
        resources = ["arn:aws:s3:::${local.www_bucket}/*"]
        #resources = ["${module.www.s3_bucket_arn}/*"]
		#resources = ["${aws_s3_bucket.files.arn}/*"]

		principals {
			type        = "AWS"
            identifiers = var.www_bucket_access
			#identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
		}
	}
}
