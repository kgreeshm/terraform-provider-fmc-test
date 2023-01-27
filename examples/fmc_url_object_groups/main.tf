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

data "fmc_url_objects" "CiscoTest" {
  name = "CiscoTest"
}

resource "fmc_url_objects" "MakingNew" {
  name        = "MNStuff"
  url       = data.fmc_url_objects.CiscoTest.url
  description = "Will it work"
}

resource "fmc_url_object_group" "TestURLGroup" {
  name = "TestURLGroup"
  description = "Testing groups"
  objects {
      id = data.fmc_url_objects.CiscoTest.id
      type = data.fmc_url_objects.CiscoTest.type
  }
  objects {
      id = fmc_url_objects.MakingNew.id
      type = fmc_url_objects.MakingNew.type
  }
  literals {
      url = "www.cisco.com"
      type = "Url"
  }
}

output "existing_fmc_url_object" {
  value = data.fmc_url_objects.CiscoTest
}

output "new_fmc_url_object" {
  value = fmc_url_objects.MakingNew
}

output "new_fmc_url_object_group" {
  value = fmc_url_object_group.TestURLGroup
}
