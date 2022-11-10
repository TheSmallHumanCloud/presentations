terraform {
  required_providers {
    nsxt = {
      source  = "vmware/nsxt"
      version = "3.2.9"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.2.0"
    }
  }
}
provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_user
  password             = var.vsphere_password
  allow_unverified_ssl = var.insecure_connection
}
provider "nsxt" {
  host                 = var.nsxt_manager
  username             = var.nsxt_user
  password             = var.nsxt_password
  allow_unverified_ssl = var.insecure_connection
}
