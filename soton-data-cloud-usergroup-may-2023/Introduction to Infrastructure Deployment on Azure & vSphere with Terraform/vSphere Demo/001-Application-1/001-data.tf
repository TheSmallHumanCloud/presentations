## Data Gathering
data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_content_library" "library" {
  name = var.vsphere_library
}
data "vsphere_content_library_item" "item" {
  name       = var.vsphere_template
  library_id = data.vsphere_content_library.library.id
  type       = "OVF"
}
data "vsphere_tag_category" "category" {
  name = var.tag_category
}
data "vsphere_tag" "webvm" {
  category_id = data.vsphere_tag_category.category.id
  name        = var.web.tag
}
data "vsphere_tag" "appvm" {
  category_id = data.vsphere_tag_category.category.id
  name        = var.app.tag
}
data "vsphere_tag" "dbvm" {
  category_id = data.vsphere_tag_category.category.id
  name        = var.db.tag
}

