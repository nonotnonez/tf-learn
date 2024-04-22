# Variables
variable "access_key" {
  type        = string
  sensitive   = true
}

variable "secret_key" {
  type        = string
  sensitive   = true
}

# Tf provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# IAM access
provider "aws" {
  region  = "ap-southeast-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# S3 Bucket
variable "domain_name" {
  description = "The name of the domain for our website."
  default = "1explorecalifornia.org"
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "PublicReadGetObject"
    effect = "Allow"
    actions = [ "s3:GetObject" ]
    principals {
      type = "*"
      identifiers = [ "*" ]
    }
    resources = [ "arn:aws:s3:::${var.domain_name}" ]
  }
}

/* We can access properties from data sources using this format:
   ${data.<data_source_type>.<data_source_name>.<property>.

   In this case, we need the JSON document, which the documentation
   says can be accessed from the .json property. */

resource "aws_s3_bucket" "website-test-1" {
  bucket = var.domain_name          // The name of the bucket.
  acl    = "public-read"            /* Access control list for the bucket.
                                       Websites need to be publicly-available
                                       to the Internet for website hosting to
                                       work. */
  policy = data.aws_iam_policy_document.bucket_policy.json
  website {
    index_document = "index.htm"   // The root of the website.
    error_document = "error.htm"   // The page to show when people hit invalid pages.
  }
}

output "website_bucket_url" {
  value = aws_s3_bucket.website-test-1.website_endpoint
}
