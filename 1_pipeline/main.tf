terraform {
  backend "s3" {
    bucket         = "df-terraform-remote-state-s3"
    key            = "df-terraform-remote-state-s3.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "df-terraform-remote-state-dynamodb"
  }
}

locals {
    aws_region  = "eu-central-1"
    prefix      = "df-terraform-remote-state"
    ssm_prefix  = "/df/terraform"
    common_tags = {
        Project         = "df-Terraform-AWS"
        ManagedBy       = "Terraform"
    }
}
