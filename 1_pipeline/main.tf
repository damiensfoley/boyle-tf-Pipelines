<<<<<<< HEAD
terraform {
  backend "s3" {
    bucket = "df-tf-remote-state-s3"
    key = "df-tf-remote-state-s3.tfstate"
    region = "eu-west-1"
    encrypt = "true"
  }
}
#test#
locals {
  aws_region  = "eu-west-1"
  prefix      = "${var.repository_name}-${var.listen_branch_name}-pipeline"
  ssm_prefix  = "/DF/terraform"
  common_tags = {
    Project         = local.prefix
    ManagedBy       = "Terraform"
  }
}

=======
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
>>>>>>> a0f44d0591a2dec80898715bdb60e39940eb56b5
