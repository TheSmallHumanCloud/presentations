#Provider Variables
variable "vsphere_server" {
  type        = string
  default     = "vc-l-01a.corp.local"
  description = "vCenter Server you are connecting to"
}
variable "vsphere_user" {
  type        = string
  sensitive   = true
  default     = "administrator@vsphere.local"
  description = "User with required permissions"
}
variable "vsphere_password" {
  type        = string
  sensitive   = true
  default     = "VMware1!"
  description = "Password for vSphere_User"
}
variable "insecure_connection" {
  type    = bool
  default = true
}

#Resource Variables
variable "vsphere_datacenter" {
  type        = string
  description = "Target Datacenter for the deployment"
}
variable "virtual_machine_name" {
  type = string
}
variable "administrator_role" {
  type = string
}
variable "custom_role" {
  type = string
}
