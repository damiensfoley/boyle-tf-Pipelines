data "aws_secretsmanager_secret" "aws_access_keys" {
  name = "aws-access-keys"
}

data "aws_secretsmanager_secret_version" "aws_access_keys_current" {
  secret_id = data.aws_secretsmanager_secret.aws_access_keys.id
}

terraform {
  backend "s3" {
    bucket         = "df-tf-remote-state-s3"
    key            = "df-tf-remote-state-s3.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    use_lockfile = true
 }
}

locals {
access_keys = jsondecode(data.aws_secretsmanager_secret_version.aws_access_keys_current.secret_string)
aws_region  = "eu-west-1"
    prefix      = "df-tf"
    ssm_prefix  = "/terraform"
    common_tags = {
        Project         = "df-terraform-aws"
        ManagedBy       = "terraform"    }
}