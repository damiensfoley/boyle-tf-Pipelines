variable "repository_name" {
  default     = ""
  description = "CodeCommit repository name for CodePipeline builds"
}

variable "github_owner" {} 
# variable "github_token" {}

variable "listen_branch_name" {
}

variable "aws_region" {}
variable "aws_secret_key" {
    type=string
    sensitive=true
}
# variable "aws_session_token" {}
variable "aws_access_key" {
    type=string
    sensitive=true
}
variable "infracost_key_api" {
  default=""
}
variable ConnectionArn {
  default=""
}
variable service_name {
  default=""
}
