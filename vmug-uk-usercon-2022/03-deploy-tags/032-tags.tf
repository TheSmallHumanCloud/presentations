#Resources
variable "environment_tags" {
  description = "List of environment tags"
}
variable "department_tags" {
  description = "List of department tags"

}

environment_tags = ["production", "test", "development"]
department_tags  = ["finance", "r&d", "sales"]

resource "vsphere_tag" "environment-tags" {
  for_each    = toset(var.environment_tags)
  name        = each.key
  category_id = vsphere_tag_category.category-environment.id
  description = "Managed by Terraform"
}

resource "vsphere_tag" "department-tags" {
  for_each    = toset(var.department_tags)
  name        = each.key
  category_id = vsphere_tag_category.category-department.id
  description = "Managed by Terraform"
}
