
variable "region" {
  description = "AWS region"
  type        = string
}

variable "env" {
  type = string
}

variable "stage" {
  type = string
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = []
}

variable "cidr" {
  description = "Primary VPC CIDR"
  type        = string
}

variable "private_subnets" {
  description = "Private subnets with NAT support for application services"
  type        = list(string)
  default     = []
}

variable "data_subnets" {
  description = "Private subnets without NAT support for data services"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "Public subnets with IGW routing"
  type        = list(string)
  default     = []
}

variable "max_az_number" {
  type    = number
  default = 3
}

variable "primary_region" {
  type    = string
  default = ""
}

variable "tags" {
  description = "Map of strings for additional cloud resource tagging"
  type        = map(string)
  default     = {}
}
