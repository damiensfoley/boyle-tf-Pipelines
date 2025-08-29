data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "remote_state_bucket" {
  name = "${local.ssm_prefix}/df-terraform-remote-state-bucket"
}

data "aws_ssm_parameter" "locks_table_arn" {
  name = "${local.ssm_prefix}/df-tf-locks-table-arn"
}

resource "aws_ssm_parameter" "infracost_api_key" {
  name  = "${local.ssm_prefix}/infracost_api_key"
  type  = "String"
  value = var.infracost_key_api
}
#test change
