locals {
  # Automated cidr creation using the logic in the following post -> https://aws.amazon.com/blogs/startups/practical-vpc-design/
  # Example in: https://docs.google.com/spreadsheets/d/1Ix1zmHUlzDvxaFgahGToTn2QzI7nnGcBIbJhH8dVZg0/edit#gid=0
  azs = length(var.availability_zones) > 0 ? var.availability_zones : slice(data.aws_availability_zones.available.names, 0, min(length(data.aws_availability_zones.available.names), var.max_az_number))

  az_count = length(local.availability_zones)

  az_reserved_bits = ceil(log(local.az_count, 2))

  az_cidr_list = [
    for az in local.availability_zones :
    cidrsubnet(var.cidr, local.az_reserved_bits, index(local.availability_zones, az))
  ]

  private_subnets = length(var.private_subnets) > 0 ? var.private_subnets : [
    for az_cidr in local.az_cidr_list : cidrsubnet(az_cidr, 1, 0)
  ]

  data_subnets = length(var.data_subnets) > 0 ? var.data_subnets : [
    for az_cidr in local.az_cidr_list : cidrsubnet(cidrsubnet(az_cidr, 1, 1), 1, 0)
  ]

  public_subnets = length(var.public_subnets) > 0 ? var.public_subnets : [
    for az_cidr in local.az_cidr_list : cidrsubnet(cidrsubnet(cidrsubnet(az_cidr, 1, 1), 1, 1), 2, 0)
  ]

  tgw_subnets = length(var.tgw_subnets) > 0 ? var.tgw_subnets : [
    for az_cidr in local.az_cidr_list : cidrsubnet(cidrsubnet(cidrsubnet(az_cidr, 1, 1), 1, 1), 2, 1)
  ]
}