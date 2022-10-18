#Providers
provider "vsphere" {
  vsphere_server       = "vc-l-01a.corp.local"
  user                 = "administrator@vsphere.local"
  password             = "VMware1!"
  allow_unverified_ssl = "true"
}
