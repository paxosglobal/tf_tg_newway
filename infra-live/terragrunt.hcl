remote_state {
  backend = "s3"
  config = {
    # The TF_VAR_BUCKET and REGION below are overriden by atlantis if there's a dr.tfvars present in the module dir
    bucket                  = "terraform.nonprod"
    key                     = "${path_relative_to_include()}/terraform.tfstate"
    region                  = "us-east-1"
    dynamodb_table          = "terraform.nonprod"
    skip_metadata_api_check = true
    role_arn                = "arn:aws:iam::769032674102:role/mgmtnonprod-mgmt-terraform-state-role"
  }
}

inputs = {
  type   = split("/", path_relative_to_include())[0]
  env    = split("/", path_relative_to_include())[1]
  stage  = split("/", path_relative_to_include())[2]
  region = split("/", path_relative_to_include())[3]
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.1"
    }
  }
}
EOF
}