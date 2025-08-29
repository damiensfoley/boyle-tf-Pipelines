# IAM
resource "aws_codepipeline" "network-destroy" {
  name     = "${local.prefix}-network-destroy"
  role_arn = aws_iam_role.codepipeline.arn
  tags     = local.common_tags

  artifact_store {
    location = aws_s3_bucket.df-tf-artifacts.id
    type     = "S3"
  }

  stage {
    name = "CloneforDestroy"

    action {
      name             = "TfStateSource"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["CodeWorkspace"]
      run_order        = "1"

      configuration = {
        BranchName           = "${var.listen_branch_name}"
        FullRepositoryId     = "${var.rds_repository_name}"
        ConnectionArn        = "${var.ConnectionArn}"
        OutputArtifactFormat = "CODE_ZIP"
        DetectChanges = "false"
      }
    }
  }

  stage {
    name = "Manual-Approval"

    action {
      run_order = 1
      name      = "DevOps-Lead-Approval"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
    }
  }

  stage {
    name = "Destroy-Test"

    action {
      run_order        = 1
      name             = "terraform-destroy"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["CodeWorkspace"]
      output_artifacts = []
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.tf_destroy.name
      }
    }
  }
}

resource "aws_codepipeline" "rds-destroy" {
  name     = "${local.prefix}-rds-destroy"
  role_arn = aws_iam_role.codepipeline.arn
  tags     = local.common_tags

  artifact_store {
    location = aws_s3_bucket.df-tf-artifacts.id
    type     = "S3"
  }

  stage {
    name = "CloneforDestroy"

    action {
      name             = "TfStateSource"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["CodeWorkspace"]
      run_order        = "1"

      configuration = {
        BranchName           = "${var.listen_branch_name}"
        FullRepositoryId     = "${var.rds_repository_name}"
        ConnectionArn        = "${var.ConnectionArn}"
        OutputArtifactFormat = "CODE_ZIP"
        DetectChanges = "false"
      }
    }
  }

  stage {
    name = "Manual-Approval"

    action {
      run_order = 1
      name      = "DevOps-Lead-Approval"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
    }
  }

  stage {
    name = "Destroy-Test"

    action {
      run_order        = 1
      name             = "terraform-destroy"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["CodeWorkspace"]
      output_artifacts = []
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.tf_destroy.name
      }
    }
  }
}