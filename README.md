# PoC comparing terraform and terragrunt

## Prerequisites
You should install AWS CLI and configure it, see https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html
Then, export the following environment variables (to be adapted to your particular set up):
```shell
export AWS_PROFILE=tfuser
export AWS_CONFIG_FILE=~/.aws/conf
export AWS_SHARED_CREDENTIALS_FILE=~/.aws/credentials
```

## Terraform

Run terraform commands:
```shell
export 
cd terraform/rule1
terraform init
terraform plan # or apply or destroy
```

## Terragrunt

Initialize terragrunt:
```shell
brew install terragrunt  # if you don't have terragrunt installed
cd terragrunt
terragrunt run-all init
```

Then, you can either run commands in each module
```shell
cd rule2
terragrunt plan # or apply or destroy
```
Or for all modules
```shell
terragrunt run-all plan # or apply or destroy
```

## Backend to store terraform state

Terraform state can be shared using an S3 bucket (and with an optional locks table),
see https://developer.hashicorp.com/terraform/language/settings/backends/s3 and 
https://technology.doximity.com/articles/terraform-s3-backend-best-practices
