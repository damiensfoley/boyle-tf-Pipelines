data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "remote_state_bucket" {
  name = "${local.ssm_prefix}/df-tf-remote-state-bucket"
}

data "aws_ssm_parameter" "locks_table_arn" {
  name = "${local.ssm_prefix}/df-tf-locks-table-arn"
}

