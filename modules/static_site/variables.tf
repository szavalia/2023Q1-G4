# FIXME: maybe just "name"
variable "bucket_name" {
    description = "The OG bucket"
    type = string
}

variable "www_bucket_access" {
  description = "Authorized bucket accessors"
  type        = list(string)
}