#Provider Variables
variable "vsphere_server" {
  type        = string
  default     = "vm-vcsa-01.smt.com"
  description = "vCenter Server you are deploying your templates to"
}
variable "vsphere_user" {
  type        = string
  sensitive   = true
  default     = "administrator@vsphere.local"
  description = "User with permissions to create VM's and import to the content library"
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

#Resource Variables
variable "vsphere_datacenter" {
  type        = string
  description = "Target Datacenter for the deployment"
}
variable "vsphere_virtual_machine" {
  type = string
}
variable "vsphere_role_1" {
  type = string
}
variable "vsphere_role_2" {
  type = string
}
