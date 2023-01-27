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

# data "fmc_access_policies" "access_policy" {
#     name = "test"
# }

data "fmc_access_policies" "access_policy" {
    name = "test"
}

resource "fmc_devices" "device"{
  name = "ftd2"
  hostname = "10.0.2.12"
  regkey = "cisco"
  type = "Device"
  license_caps = [ "MALWARE" ]
  access_policy {
      id = data.fmc_access_policies.access_policy.id
      type = data.fmc_access_policies.access_policy.type
  }
}

output "fmc_devicess" {
    value = fmc_devices.device
}