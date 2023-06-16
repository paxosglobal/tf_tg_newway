module "vpc" {
  source = "../../../../../../infra-module/network"
  cidr = "10.0.0.0/16"
}