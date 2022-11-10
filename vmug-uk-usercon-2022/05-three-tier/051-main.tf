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
  name          = var.vsphere_port_group.web
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_network" "app-network" {
  name          = var.vsphere_port_group.app
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_network" "db-network" {
  name          = var.vsphere_port_group.db
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_content_library" "library" {
  name = var.vsphere_library
}
data "vsphere_content_library_item" "template" {
  name       = var.vsphere_template
  library_id = data.vsphere_content_library.library.id
  type       = "OVF"
}

#Build Application vSphere Folders

resource "vsphere_folder" "environment-folder" {
  path          = "applications/${var.application_name}"
  type          = var.vsphere_vm_folder_type
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_folder" "child-environment-folder" {
  path          = "${vsphere_folder.environment-folder.path}/${terraform.workspace}"
  type          = var.vsphere_vm_folder_type
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
