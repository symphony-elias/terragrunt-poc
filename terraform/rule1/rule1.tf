module "not_encrypted_s3_bucket" {
  source = "../../modules/private-s3-bucket"

  bucket_name = "ec-tf-test-not-encrypted-bucket"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "encrypted_s3_bucket" {
  source = "../../modules/private-s3-bucket"

  bucket_name = "ec-tf-test-encrypted-bucket"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_kms_key" "bucket_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = module.encrypted_s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.bucket_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

output "encrypted_bucket_arn" {
  description = "ARN of the bucket"
  value       = module.encrypted_s3_bucket.arn
}

output "encrypted_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.encrypted_s3_bucket.id
}

output "not_encrypted_bucket_arn" {
  description = "ARN of the bucket"
  value       = module.not_encrypted_s3_bucket.arn
}

output "not_encrypted_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.not_encrypted_s3_bucket.id
}
