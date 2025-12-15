provider "aws" {
  region = var.primary_region
}

provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}

module "lambda_primary" {
  source = "./lambda"
  providers = { aws = aws }
}

module "lambda_secondary" {
  source = "./lambda"
  providers = { aws = aws.secondary }
}

resource "aws_fis_experiment_template" "lambda_kill" {
  description = "Kill Lambda in primary region"
  role_arn    = var.fis_role

  action {
    action_id   = "aws:lambda:inject-permission-error"
    parameters  = { percentage = "100" }
    targets     = { Function = "lambda-primary" }
  }

  stop_conditions {
    source = "none"
  }
}
