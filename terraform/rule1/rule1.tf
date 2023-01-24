module "website_s3_bucket" {
  source = "../../modules/private-s3-bucket"

  bucket_name = "ec-tf-test-module-bucket"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

output "website_bucket_arn" {
  description = "ARN of the bucket"
  value       = module.website_s3_bucket.arn
}

output "website_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.website_s3_bucket.name
}
