terraform {
  required_providers {
    fmc = {
      source = "CiscoDevNet/fmc"
      # version = "0.1.1"
    }
  }
}

provider "fmc" {
  fmc_username = var.fmc_username
  fmc_password = var.fmc_password
  fmc_host = var.fmc_host
  fmc_insecure_skip_verify = var.fmc_insecure_skip_verify
}

data "fmc_network_objects" "PrivateVLAN" {
  name = "VLAN825-Private"
}

resource "fmc_network_objects" "PrivateVLANDR" {
  name        = "DRsite-VLAN"
  value       = data.fmc_network_objects.PrivateVLAN.value
  description = "testing terraform"
}

resource "fmc_network_group_objects" "TestPrivateGroup" {
  name = "TestPrivateGroup"
  description = "Testing groups"
  objects {
      id = data.fmc_network_objects.PrivateVLAN.id
      type = data.fmc_network_objects.PrivateVLAN.type
  }
  objects {
      id = fmc_network_objects.PrivateVLANDR.id
      type = fmc_network_objects.PrivateVLANDR.type
  }
  literals {
      value = "10.10.10.10"
      type = "Host"
  }
}

output "existing_fmc_network_object" {
  value = data.fmc_network_objects.PrivateVLAN
}

output "new_fmc_network_object" {
  value = fmc_network_objects.PrivateVLANDR
}

output "new_fmc_network_group_object" {
  value = fmc_network_group_objects.TestPrivateGroup
}
