variable "vpc_id" {
  description = "Platform VPC ID"
  type        = string
}

variable "route_table_ids" {
  description = "The list of route table IDs to add the routes to"
  type        = list(string)
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `stage`)"
  type        = string
}

variable "peerings_data" {
  description = "Details data required for VPC peering"
  type        = any
  default     = []
}
