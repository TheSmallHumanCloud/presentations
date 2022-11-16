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
#Content Library & Template
data "vsphere_content_library" "library" {
  name = var.vsphere_library
}
data "vsphere_content_library_item" "template" {
  name       = var.vsphere_template
  library_id = data.vsphere_content_library.library.id
  type       = "OVF"
}

#Network
data "nsxt_policy_tier1_gateway" "t1" {
  display_name = var.t1_name
}
data "nsxt_policy_transport_zone" "overlay_tz" {
  display_name = var.overlay_name
}
data "nsxt_policy_segment_realization" "web-network" {
  path = nsxt_policy_segment.web-network.path
}
data "vsphere_network" "web-network" {
  name          = data.nsxt_policy_segment_realization.web-network.network_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "nsxt_policy_segment_realization" "app-network" {
  path = nsxt_policy_segment.app-network.path
}
data "vsphere_network" "app-network" {
  name          = data.nsxt_policy_segment_realization.app-network.network_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "nsxt_policy_segment_realization" "db-network" {
  path = nsxt_policy_segment.db-network.path
}
data "vsphere_network" "db-network" {
  name          = data.nsxt_policy_segment_realization.db-network.network_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "nsxt_policy_lb_service" "webservice" {
  display_name      = "lb-01"
}
data "nsxt_policy_lb_app_profile" "default" {
  type         = "HTTP"
  display_name = var.lb_app_profile
}

#Tags
data "vsphere_tag_category" "category-environment" {
  name = var.category_environment
}
data "vsphere_tag" "environment-tag" {
  name        = var.environment_tags[terraform.workspace]
  category_id = data.vsphere_tag_category.category-environment.id
}

#Build Application vSphere Folders
resource "vsphere_folder" "environment-folder" {
  path          = "applications/${terraform.workspace}"
  type          = var.vsphere_vm_folder_type
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_folder" "child-environment-folder" {
  path          = "${vsphere_folder.environment-folder.path}/${var.application_name}"
  type          = var.vsphere_vm_folder_type
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
