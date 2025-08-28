<<<<<<< HEAD
provider "aws" {
  region = local.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  # token      = var.aws_session_token
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }
=======
provider "aws" {
  region = local.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  #token      = var.aws_session_token
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }
>>>>>>> a0f44d0591a2dec80898715bdb60e39940eb56b5
}