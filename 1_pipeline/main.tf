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
aws_region  = "eu-west-1"
    prefix      = "df-tf"
    ssm_prefix  = "/terraform"
    common_tags = {
        Project         = "df-terraform-aws"
        ManagedBy       = "terraform"    }
}