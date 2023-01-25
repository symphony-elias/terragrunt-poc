module "allow_http_s3_bucket" {
  source = "../../modules/private-s3-bucket"
  bucket_name = "ec-tf-allow-http-bucket"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "deny_http_s3_bucket" {
  source = "../../modules/private-s3-bucket"
  bucket_name = "ec-tf-allow-http-bucket"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_policy" "deny_http" {
  bucket = module.deny_http_s3_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "BUCKET-POLICY"
    Statement = [
      {
        Sid       = "EnforceTls"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${module.deny_http_s3_bucket.arn}/*",
          "${module.deny_http_s3_bucket.arn}",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        Sid       = "EnforceProtoVer"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${module.deny_http_s3_bucket.arn}/*",
          "${module.deny_http_s3_bucket.arn}",
        ]
        Condition = {
          NumericLessThan = {
            "s3:TlsVersion": 1.2
          }
        }
      }
    ]
  })
}

output "allow_http_bucket_arn" {
  description = "ARN of the bucket"
  value       = module.allow_http_s3_bucket.arn
}

output "allow_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.allow_http_s3_bucket.id
}

output "deny_http_bucket_arn" {
  description = "ARN of the bucket"
  value       = module.deny_http_s3_bucket.arn
}

output "deny_http_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.deny_http_s3_bucket.id
}
