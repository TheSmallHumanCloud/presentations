#Resources
resource "vsphere_tag_category" "category-environment" {
  name        = "environment"
  description = "Managed by Terraform"
  cardinality = "SINGLE"

  associable_types = [
    "VirtualMachine",
    "Datastore",
  ]
}
resource "vsphere_tag_category" "category-department" {
  name        = "department"
  description = "Managed by Terraform"
  cardinality = "MULTIPLE"

  associable_types = [
    "VirtualMachine"
  ]
}
