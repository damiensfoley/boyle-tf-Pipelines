provider "aws" {
  region     = var.aws_region
  access_key = local.access_keys.aws_access_key_id
  secret_key = local.access_keys.aws_secret_access_key
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.11.0"
    }
  }
}