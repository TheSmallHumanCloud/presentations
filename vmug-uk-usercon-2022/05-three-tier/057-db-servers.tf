#db Server Resources

resource "vsphere_folder" "db-tier-folder" {
  path          = "${vsphere_folder.child-environment-folder.path}/${var.virtualmachine.db.folder}"
  type          = var.vsphere_vm_folder_type
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "db-01" {
  depends_on = [
    nsxt_policy_segment.db-network
  ]
  name             = "vm-${terraform.workspace}-${var.virtualmachine.db.a_computer_name}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus             = var.virtualmachine.db.num_cpus
  num_cores_per_socket = var.virtualmachine.db.num_cores_per_socket
  memory               = var.virtualmachine.db.memory
  folder               = vsphere_folder.db-tier-folder.path
  guest_id             = var.virtualmachine.db.guest_id
  firmware             = var.virtualmachine.db.firmware
  hardware_version     = var.virtualmachine.db.hardware_version
  network_interface {
    network_id   = nsxt_policy_segment.db-network.id
    adapter_type = var.virtualmachine.db.adapter_type
  }
  clone {
    template_uuid = data.vsphere_content_library_item.template.id
    timeout       = 60
    customize {
      timeout = 30
      linux_options {
        host_name = "vm-${terraform.workspace}-${var.virtualmachine.db.a_computer_name}"
        domain    = var.virtualmachine.db.join_domain
      }
      network_interface {
        ipv4_address = var.virtualmachine.db.a_ipv4_address
        ipv4_netmask = var.virtualmachine.db.ipv4_netmask
      }
      ipv4_gateway    = var.virtualmachine.db.ipv4_gateway
      dns_server_list = var.virtualmachine.db.dns_server_list
      dns_suffix_list = [var.virtualmachine.db.join_domain]
    }
  }
  scsi_controller_count = var.virtualmachine.db.scsi_controller_count
  scsi_type             = var.virtualmachine.db.scsi_type
  disk {
    size             = var.virtualmachine.db.disk_size_0
    label            = var.virtualmachine.db.disk_label_0
    eagerly_scrub    = var.virtualmachine.db.disk_eagerly_scrub_0
    thin_provisioned = var.virtualmachine.db.disk_thin_provisioned_0
    unit_number      = var.virtualmachine.db.disk_unit_number_0
  }
}

resource "vsphere_virtual_machine" "db-02" {
  depends_on = [
    nsxt_policy_segment.db-network
  ]
  name             = "vm-${terraform.workspace}-${var.virtualmachine.db.b_computer_name}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus             = var.virtualmachine.db.num_cpus
  num_cores_per_socket = var.virtualmachine.db.num_cores_per_socket
  memory               = var.virtualmachine.db.memory
  folder               = vsphere_folder.db-tier-folder.path
  guest_id             = var.virtualmachine.db.guest_id
  firmware             = var.virtualmachine.db.firmware
  hardware_version     = var.virtualmachine.db.hardware_version
  network_interface {
    network_id   = nsxt_policy_segment.db-network.id
    adapter_type = var.virtualmachine.db.adapter_type
  }
  clone {
    template_uuid = data.vsphere_content_library_item.template.id
    timeout       = 60
    customize {
      timeout = 30
      linux_options {
        host_name = "vm-${terraform.workspace}-${var.virtualmachine.db.b_computer_name}"
        domain    = var.virtualmachine.db.join_domain
      }
      network_interface {
        ipv4_address = var.virtualmachine.db.b_ipv4_address
        ipv4_netmask = var.virtualmachine.db.ipv4_netmask
      }
      ipv4_gateway    = var.virtualmachine.db.ipv4_gateway
      dns_server_list = var.virtualmachine.db.dns_server_list
      dns_suffix_list = [var.virtualmachine.db.join_domain]
    }
  }
  scsi_controller_count = var.virtualmachine.db.scsi_controller_count
  scsi_type             = var.virtualmachine.db.scsi_type
  disk {
    size             = var.virtualmachine.db.disk_size_0
    label            = var.virtualmachine.db.disk_label_0
    eagerly_scrub    = var.virtualmachine.db.disk_eagerly_scrub_0
    thin_provisioned = var.virtualmachine.db.disk_thin_provisioned_0
    unit_number      = var.virtualmachine.db.disk_unit_number_0
  }
}
