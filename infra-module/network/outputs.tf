output "account" {
  description = "VPC AWS Account ID"
  value       = data.aws_caller_identity.current.account_id 
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "public_route_table_ids" {
  value = module.vpc.public_route_table_ids
}

output "data_subnets" {
  value = module.vpc.database_subnets
}

output "data_route_table_ids" {
  value = module.vpc.database_route_table_ids
}

output "data_subnets_cidr_blocks" {
  value = module.vpc.database_subnets_cidr_blocks
}