#App Server Resources

resource "vsphere_folder" "app-tier-folder" {
  path          = "${vsphere_folder.child-environment-folder.path}/${var.virtualmachine.app.folder}"
  type          = var.vsphere_vm_folder_type
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "app-01" {
  name             = "vm-${terraform.workspace}-${var.virtualmachine.app.a_computer_name}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus             = var.virtualmachine.app.num_cpus
  num_cores_per_socket = var.virtualmachine.app.num_cores_per_socket
  memory               = var.virtualmachine.app.memory
  folder               = vsphere_folder.app-tier-folder.path
  guest_id             = var.virtualmachine.app.guest_id
  firmware             = var.virtualmachine.app.firmware
  hardware_version     = var.virtualmachine.app.hardware_version
  network_interface {
    network_id   = nsxt_policy_segment.app-network.id
    adapter_type = var.virtualmachine.app.adapter_type
  }
  clone {
    template_uuid = data.vsphere_content_library_item.template.id
    timeout       = 60
    customize {
      timeout = 30
      linux_options {
        host_name = "vm-${terraform.workspace}-${var.virtualmachine.app.a_computer_name}"
        domain    = var.virtualmachine.app.join_domain
      }
      network_interface {
        ipv4_address = var.virtualmachine.app.a_ipv4_address
        ipv4_netmask = var.virtualmachine.app.ipv4_netmask
      }
      ipv4_gateway    = var.virtualmachine.app.ipv4_gateway
      dns_server_list = var.virtualmachine.app.dns_server_list
      dns_suffix_list = [var.virtualmachine.app.join_domain]
    }
  }
  scsi_controller_count = var.virtualmachine.app.scsi_controller_count
  scsi_type             = var.virtualmachine.app.scsi_type
  disk {
    size             = var.virtualmachine.app.disk_size_0
    label            = var.virtualmachine.app.disk_label_0
    eagerly_scrub    = var.virtualmachine.app.disk_eagerly_scrub_0
    thin_provisioned = var.virtualmachine.app.disk_thin_provisioned_0
    unit_number      = var.virtualmachine.app.disk_unit_number_0
  }
}

resource "vsphere_virtual_machine" "app-02" {
  name             = "vm-${terraform.workspace}-${var.virtualmachine.app.b_computer_name}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus             = var.virtualmachine.app.num_cpus
  num_cores_per_socket = var.virtualmachine.app.num_cores_per_socket
  memory               = var.virtualmachine.app.memory
  folder               = vsphere_folder.app-tier-folder.path
  guest_id             = var.virtualmachine.app.guest_id
  firmware             = var.virtualmachine.app.firmware
  hardware_version     = var.virtualmachine.app.hardware_version
  network_interface {
    network_id   = nsxt_policy_segment.app-network.id
    adapter_type = var.virtualmachine.app.adapter_type
  }
  clone {
    template_uuid = data.vsphere_content_library_item.template.id
    timeout       = 60
    customize {
      timeout = 30
      linux_options {
        host_name = "vm-${terraform.workspace}-${var.virtualmachine.app.b_computer_name}"
        domain    = var.virtualmachine.app.join_domain
      }
      network_interface {
        ipv4_address = var.virtualmachine.app.b_ipv4_address
        ipv4_netmask = var.virtualmachine.app.ipv4_netmask
      }
      ipv4_gateway    = var.virtualmachine.app.ipv4_gateway
      dns_server_list = var.virtualmachine.app.dns_server_list
      dns_suffix_list = [var.virtualmachine.app.join_domain]
    }
  }
  scsi_controller_count = var.virtualmachine.app.scsi_controller_count
  scsi_type             = var.virtualmachine.app.scsi_type
  disk {
    size             = var.virtualmachine.app.disk_size_0
    label            = var.virtualmachine.app.disk_label_0
    eagerly_scrub    = var.virtualmachine.app.disk_eagerly_scrub_0
    thin_provisioned = var.virtualmachine.app.disk_thin_provisioned_0
    unit_number      = var.virtualmachine.app.disk_unit_number_0
  }
}
