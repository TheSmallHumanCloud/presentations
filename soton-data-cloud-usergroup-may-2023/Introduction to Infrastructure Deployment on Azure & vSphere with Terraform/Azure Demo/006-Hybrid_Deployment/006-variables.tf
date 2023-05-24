variable "azure_location" {
  type    = string
  default = "UK South"
}
variable "vsphere_server" {
  type    = string
  default = "vm-vcsa-01.smt-lab.local"
}
variable "vsphere_user" {
  type    = string
  default = "stephan@smt-lab.local"
}
variable "vsphere_password" {}
variable "azure_username" {}
variable "azure_password" {}
variable "vsphere_datacenter" {
  type    = string
  default = "dc-smt-01"
}
variable "vsphere_datastore" {
  type    = string
  default = "ds-vsan-01"
}
variable "vsphere_compute_cluster" {
  type    = string
  default = "cl-vsan-01"
}
variable "vsphere_network" {}
variable "vsphere_library" {
  type    = string
  default = "Images"
}
variable "vsphere_template" {}
variable "computer_name" {}
variable "num_cpus" {}
variable "num_cores_per_socket" {}
variable "memory" {}
variable "folder" {}
variable "wait_for_guest_net_timeout" {}
variable "guest_id" {}
variable "firmware" {}
variable "nested_hv_enabled" {}
variable "hardware_version" {}
variable "annotation" {}
variable "adapter_type" {
  type    = string
  default = "vmxnet3"
}
variable "ipv4_address" {}
variable "ipv4_netmask" {}
variable "ipv4_gateway" {}
variable "dns_server_list" {}
variable "join_domain" {}
variable "scsi_controller_count" {}
variable "scsi_type" {
  type    = string
  default = "pvscsi"
}
variable "disk_size_0" {}
variable "disk_label_0" {}
variable "disk_eagerly_scrub_0" {}
variable "disk_thin_provisioned_0" {}
variable "disk_unit_number_0" {}
