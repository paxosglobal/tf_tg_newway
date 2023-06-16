module "vpc" {
  source   = "terraform-aws-modules/vpc/aws"
  version  = "v5.0.0"
  name     = "${var.env}-${var.stage}"
  cidr     = var.cidr
  azs      = local.azs
  # TODO: Removed the subnet group resource, expecting this to now work on a later version. Needs test.
  

  database_subnets  = local.data_subnets
  private_subnets   = local.private_subnets
  public_subnets    = local.public_subnets

  enable_dns_hostnames   = true
  enable_nat_gateway     = true
  single_nat_gateway     = true

}

module "vpc-peering" {
  count = var.primary_region != "" ? 1 : 0

  source = "./modules/vpc_peering"

  env   = var.env
  stage = var.stage

  vpc_id          = module.vpc.vpc_id
  route_table_ids = module.vpc.private_route_table_ids

  peerings_data = [
    {
        account = data.terraform_remote_state.primary_network[0].outputs.account
        vpc_id  = data.terraform_remote_state.primary_network[0].outputs.vpc_id
        cidrs   = data.terraform_remote_state.primary_network[0].private_subnets_cidr_blocks
    }
  ]
}
