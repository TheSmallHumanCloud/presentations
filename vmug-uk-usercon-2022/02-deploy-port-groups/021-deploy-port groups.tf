#Providers
provider "vsphere" {
  vsphere_server       = "vc-l-01a.corp.local"
  user                 = "administrator@vsphere.local"
  password             = "VMware1!"
  allow_unverified_ssl = "true"
}

#Resources
data "vsphere_datacenter" "datacenter" {
  name = "sfo-m01-dc01"
}
data "vsphere_distributed_virtual_switch" "vds" {
  name          = "sfo-m01-cl01-vds01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
resource "vsphere_distributed_port_group" "pg101" {
  name                            = "sfo01-m01-cl01-vds01-pg-app"
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.vds.id
  vlan_id                         = 101
}
resource "vsphere_distributed_port_group" "pg102" {
  name                            = "sfo01-m01-cl01-vds01-pg-db"
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.vds.id
  vlan_id                         = 102
}
