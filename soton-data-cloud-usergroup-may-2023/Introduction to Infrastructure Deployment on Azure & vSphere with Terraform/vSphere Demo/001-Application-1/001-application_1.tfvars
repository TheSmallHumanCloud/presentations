vsphere_network  = "dvPG_terraform_test"
vsphere_template = "tmpl-win-2022-core"
tag_category     = "environment"

web = {
  computer_name              = "vm-web-01"
  num_cpus                   = "2"
  num_cores_per_socket       = "2"
  memory                     = "4096"
  folder                     = "demo-vms"
  wait_for_guest_net_timeout = 0
  guest_id                   = "windows2019srvNext_64Guest"
  firmware                   = "efi"
  hardware_version           = 19
  annotation                 = "Built using Terraform"
  ipv4_address               = "10.200.149.230"
  ipv4_netmask               = 24
  ipv4_gateway               = "10.200.149.254"
  dns_server_list            = "10.200.15.10"
  scsi_controller_count      = 1
  disk_size_0                = 100
  disk_label_0               = "Disk0.vmdk"
  disk_eagerly_scrub_0       = false
  disk_thin_provisioned_0    = true
  disk_unit_number_0         = 0
  tag                        = "production"

}
app = {
  computer_name              = "vm-app-01"
  num_cpus                   = "2"
  num_cores_per_socket       = "2"
  memory                     = "4096"
  folder                     = "demo-vms"
  wait_for_guest_net_timeout = 0
  guest_id                   = "windows2019srvNext_64Guest"
  firmware                   = "efi"
  hardware_version           = 19
  annotation                 = "Built using Terraform"
  ipv4_address               = "10.200.149.231"
  ipv4_netmask               = 24
  ipv4_gateway               = "10.200.149.254"
  dns_server_list            = "10.200.15.10"
  scsi_controller_count      = 1
  disk_size_0                = 100
  disk_label_0               = "Disk0.vmdk"
  disk_eagerly_scrub_0       = false
  disk_thin_provisioned_0    = true
  disk_unit_number_0         = 0
  tag                        = "production"
}
db = {
  computer_name              = "vm-db-01"
  num_cpus                   = "2"
  num_cores_per_socket       = "2"
  memory                     = "4096"
  folder                     = "demo-vms"
  wait_for_guest_net_timeout = 0
  guest_id                   = "windows2019srvNext_64Guest"
  firmware                   = "efi"
  hardware_version           = 19
  annotation                 = "Built using Terraform"
  ipv4_address               = "10.200.149.232"
  ipv4_netmask               = 24
  ipv4_gateway               = "10.200.149.254"
  dns_server_list            = "10.200.15.10"
  scsi_controller_count      = 1
  disk_size_0                = 100
  disk_label_0               = "Disk0.vmdk"
  disk_eagerly_scrub_0       = false
  disk_thin_provisioned_0    = true
  disk_unit_number_0         = 0
  tag                        = "production"
}
