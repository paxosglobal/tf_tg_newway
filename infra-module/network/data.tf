data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "terraform_remote_state" "primary_network" {
  count   = var.primary_region != "" ? 1 : 0
  backend = "s3"

  config = {
    bucket  = var.remote_state_bucket
    region  = var.remote_bucket_region
    key     = "${var.type}/${var.env}/${var.stage}/${var.primary_region}/network/terraform.tfstate"
    profile = var.remote_state_profile
  }
}