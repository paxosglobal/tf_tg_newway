terraform {
  source = "../../../../../..//infra-module/network"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  cidr = "10.0.0.0/16"
}
