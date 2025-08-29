terraform {
  backend "s3" {
    bucket         = "df-terraform-remote-state-s3"
    key            = "df-terraformf-remote-state-s3.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    use_lockfile = true
    dynamodb_table = "df-tf-locks-table"
  }
}

locals {
    aws_region  = "eu-west-1"
    prefix      = "df-tf-remote-state"
    ssm_prefix  = "/df/terraform"
    common_tags = {
        Project         = "df-Terraform-AWS"
        ManagedBy       = "Terraform"
    }
}
