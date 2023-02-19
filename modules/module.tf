#The provider block configures the provider to be used for this template
provider "aws" {
  profile = var.profile_name
  region = var.region_name
}

#The resource block creates an S3 bucket with a private access.
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl = "private"
}

#The resource block restricts public access to the bucket.
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

locals {
  s3_origin_id = "S3-${aws_s3_bucket.this.id}"
}

#The esource block creates a CloudFront origin access identity that is associated with the S3 bucket.
resource "aws_cloudfront_origin_access_identity" "this" {
  depends_on = [
    aws_s3_bucket.this,
  ]
}

#The resource block creates a CloudFront distribution and sets the S3 bucket as its origin.
resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = "${aws_s3_bucket.this.bucket_regional_domain_name}"
    origin_id                = local.s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = var.default_root_object
  price_class         = var.price_class

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type            = "none"
    }
  }

  default_cache_behavior {
    target_origin_id     = local.s3_origin_id
    allowed_methods      = ["HEAD", "GET"]
    cached_methods       = ["HEAD", "GET"]
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }

}

#The resource block creates a bucket policy that allows the CloudFront origin access identity to access objects in the S3 bucket.
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:GetObject"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.this.id}"
        }
        Resource = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}
