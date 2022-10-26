#Data
#Datacenter
data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}
#Datastore
data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
#Cluster
data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
#PortGroups
data "vsphere_network" "web-network" {
  name          = var.vsphere_port_group[terraform.workspace].web
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_network" "app-network" {
  name          = var.vsphere_port_group[terraform.workspace].app
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_network" "db-network" {
  name          = var.vsphere_port_group[terraform.workspace].db
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_content_library" "library" {
  name = var.vsphere_library
}
