##Provider Variables
variable "vsphere_server" {
  type        = string
  default     = "vc-l-01a.corp.local"
  description = "vCenter Server"
}
variable "vsphere_user" {
  type        = string
  sensitive   = true
  description = "User with permissions to build resources"
}
variable "vsphere_password" {
  type        = string
  sensitive   = true
  description = "Password for vSphere_User"
}
variable "insecure_connection" {
  type        = bool
  default     = true
  description = "Requires the target vCenter Server to have a valid, trusted certificate"
}

variable "nsxt_manager" {
  type        = string
  default     = "nsx01.corp.local"
  description = "NSX Manager"
}
variable "nsxt_user" {
  type        = string
  sensitive   = true
  description = "User with permissions to build resources"
}
variable "nsxt_password" {
  type        = string
  sensitive   = true
  description = "Password for vSphere_User"
}

#Network Variables
variable "nsxt_networks" {
  type        = map(any)
  description = "NSX Segments"
}
variable "t1_name" {
  type        = string
  description = "Tier 1 NSX-T router"
}
variable "overlay_name" {
  type        = string
  description = "Overlay Network name"
}
variable "load_balancer" {
  type        = map(any)
  description = "Overlay Network name"
}
##Compute Variables
variable "vsphere_vm_folder_type" {
  type        = string
  description = "vSphere folder type for deployment"
}
variable "vsphere_datacenter" {
  type        = string
  description = "Target Datacenter for the deployment"
}
variable "vsphere_compute_cluster" {
  type        = string
  description = "Target Cluster for the deployment"
}
variable "vsphere_datastore" {
  type        = string
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
variable "vsphere_template" {
  type        = string
  description = "vSphere Content Library template name"
}

##Virtual Machine Variables
variable "virtualmachine" {
  type        = map(any)
  description = "Port groups for each environment and tier"
}


#Application & Department Variables
variable "application_name" {
  type        = string
  description = "Application name"
}
variable "department" {
  type        = string
  description = "Department name"
}

#Tag Variables
variable "category_environment" {
}
variable "category_department" {
}
variable "environment_tags" {
  description = "List of environment tags"
}
variable "department_tags" {
  description = "List of department tags"

}
