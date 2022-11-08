##Provider Variables
variable "vsphere_server" {
  type        = string
  default     = "vm-vcsa-01.smt.com"
  description = "vCenter Server"
}
variable "vsphere_user" {
  type        = string
  sensitive   = true
  default     = "administrator@vsphere.local"
  description = "User with permissions to build resources"
}
variable "vsphere_password" {
  type        = string
  sensitive   = true
  default     = "VMware123!"
  description = "Password for vSphere_User"
}
variable "insecure_connection" {
  type        = bool
  default     = true
  description = "Requires the target vCenter Server to have a valid, trusted certificate"
}

##Compute Variables
variable "vsphere_vm_folder_type" {
  type        = string
  description = "vSphere folder type for deployment"
}
variable "vsphere_datacenter" {
  type        = string
  default     = "home-lab"
  description = "Target Datacenter for the deployment"
}
variable "vsphere_compute_cluster" {
  type        = string
  default     = "physical-cluster"
  description = "Target Cluster for the deployment"
}
variable "vsphere_datastore" {
  type        = string
  default     = "ds-vmfs-01"
  description = "Target Datastore for the deployment"
}
variable "vsphere_port_group" {
  type        = map(any)
  description = "Port groups for each environment and tier"
}
variable "vsphere_library" {
  type        = string
  description = "vSphere Content Library name"
}
variable "environment-tag" {
}
variable "department-tag" {
}

##Virtual Machine Variables
variable "virtualmachine" {
  type        = map(any)
  description = "Port groups for each environment and tier"
}
