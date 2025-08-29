locals {
aws_region  = "eu-west-1"
    prefix      = "df-tf-remote-state"
    ssm_prefix  = "/terraform"
    common_tags = {
        Project         = "df-terraform-aws"
        ManagedBy       = "terraform"    }
}
