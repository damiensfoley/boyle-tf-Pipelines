locals {
    aws_region  = "eu-west-1"
    prefix      = "df-tf-remote-state"
    ssm_prefix  = "/DF/terraform"
    common_tags = {
        Project         = "DF-Terraform-AWS"
        ManagedBy       = "Terraform"
    }
}
