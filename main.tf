terraform {
  required_providers {
    bigip = {
      source  = "F5Networks/bigip"
      version = "1.4.0"
    }
  }
  backend "remote" {
    organization = "SCStest"
    workspaces {
      name = "bigip-ci"
    }
  }
}
provider "aws" {
  region = "us-west-2"
}
provider "bigip" {
  address  = "https://${var.address}:${var.port}"
  username = var.username
  password = var.password
}

# deploy application using as3
resource "bigip_as3" "DeployApp" {
  //Deploy application with WAF Policy
  as3_json = file(var.deployWAF)
}
