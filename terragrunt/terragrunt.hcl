generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "ecroze-tf-state"
    key            = "state/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "alias/ecroze-tf-bucket-key"
    dynamodb_table = "ecroze-terraform-state"
  }
}

# Configure the AWS Provider. Config files will be passed as env variables
provider "aws" {
  region = "us-east-1"
}
EOF
}
