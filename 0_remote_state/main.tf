<<<<<<< HEAD
locals {
    aws_region  = "eu-west-1"
    prefix      = "df-tf-remote-state"
    ssm_prefix  = "/DF/terraform"
    common_tags = {
        Project         = "DF-Terraform-AWS"
        ManagedBy       = "Terraform"
    }
}
=======
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
