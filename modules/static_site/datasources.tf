# TODO: ver si se puede en un for each

data "aws_iam_policy_document" "www" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${local.www_bucket}" ,"arn:aws:s3:::${local.www_bucket}/*"]

    principals {
      type        = "AWS"
      identifiers = var.www_bucket_access
    }
  }
}

/* 
data "aws_iam_policy_document" "site" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/*"]
    #resources = ["${module.www.s3_bucket_arn}/*"]
    #resources = ["${aws_s3_bucket.files.arn}/*"]

	principals {
	  type = "Service"
	  identifiers = ["s3.amazonaws.com"]

	}
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:s3:::${local.www_bucket}"]
    }
  }
}
*/

data "aws_iam_policy_document" "site" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}" ,"arn:aws:s3:::${var.bucket_name}/*"]

    principals {
      type        = "AWS"
      identifiers = var.www_bucket_access
    }
  }
}


