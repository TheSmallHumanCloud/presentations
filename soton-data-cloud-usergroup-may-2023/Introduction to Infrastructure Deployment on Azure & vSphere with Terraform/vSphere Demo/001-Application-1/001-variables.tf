variable "vsphere_server" {
  type        = string
  default     = "vc01.my-sddc.vcd"
  description = "vCenter Server DNS name that you intend to deploy to"
}
variable "vsphere_user" {
  type        = string
  sensitive   = true
  description = "Default user account for accessing vCenter"
}
variable "vsphere_password" {
  type        = string
  description = "Password for the vCenter User"
  sensitive   = true
}
variable "vsphere_datacenter" {
  type        = string
  default     = "dc01"
  description = "vSphere Datacenter that the configuration is to be deployed to"
}
variable "vsphere_datastore" {
  type        = string
  default     = "vsan01"
  description = "vSphere Datastore that the configuration is to be deployed to"
}
variable "vsphere_compute_cluster" {
  type        = string
  default     = "cl01"
  description = "vSphere Cluster that the configuration is to be deployed to"
}
variable "vsphere_network" {
  description = "vSphere Network that the configuration is to be deployed to"
}
variable "vsphere_library" {
  type        = string
  default     = "media-templates"
  description = "Content Library that hosts the Content Library item you intend to use"
}
variable "vsphere_template" {
  type        = string
  description = "Content Library Template that you intend to use"
}
variable "join_domain" {
  type        = string
  description = "Active Directory Domain to join the VM to"
  default     = "my-sddc.vcd"
}
variable "domain_admin_user" {
  type        = string
  sensitive   = true
  description = "Active Directory Domain User"
}
variable "domain_admin_password" {
  type        = string
  sensitive   = true
  description = "Active Directory Domain Password"
}
variable "scsi_type" {
  type        = string
  description = "Specify the disk controller type, LSI Logic, PVSCSI, NVMe"
  default     = "pvscsi"
}
variable "adapter_type" {
  type    = string
  default = "vmxnet3"
}
variable "tag_category" {
  type = string
}

variable "web" {
  type = map(any)
}
variable "app" {
  type = map(any)
}
variable "db" {
  type = map(any)
}
