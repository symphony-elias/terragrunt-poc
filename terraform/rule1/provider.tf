terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "ecroze-tf-state"
    key            = "state/rule1/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "alias/ecroze-tf-bucket-key"
    dynamodb_table = "ecroze-terraform-state"
  }
}

provider "aws" {
  region = "us-east-1"
}
