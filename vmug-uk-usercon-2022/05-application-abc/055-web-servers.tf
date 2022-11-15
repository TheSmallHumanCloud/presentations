#Web Server Resources

resource "vsphere_folder" "web-tier-folder" {
  path          = "${vsphere_folder.child-environment-folder.path}/${var.virtualmachine.web.folder}"
  type          = var.vsphere_vm_folder_type
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "web-01" {
  name             = "vm-${terraform.workspace}-${var.virtualmachine.web.a_computer_name}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus             = var.virtualmachine.web.num_cpus
  num_cores_per_socket = var.virtualmachine.web.num_cores_per_socket
  memory               = var.virtualmachine.web.memory
  folder               = vsphere_folder.web-tier-folder.path
  guest_id             = var.virtualmachine.web.guest_id
  firmware             = var.virtualmachine.web.firmware
  hardware_version     = var.virtualmachine.web.hardware_version
  network_interface {
    network_id   = data.vsphere_network.web-network.id
    adapter_type = var.virtualmachine.web.adapter_type
  }
  clone {
    template_uuid = data.vsphere_content_library_item.template.id
    timeout       = 60
    customize {
      timeout = 30
      linux_options {
        host_name = "vm-${terraform.workspace}-${var.virtualmachine.web.a_computer_name}"
        domain    = var.virtualmachine.web.join_domain
      }
      network_interface {
        ipv4_address = var.virtualmachine.web.a_ipv4_address
        ipv4_netmask = var.virtualmachine.web.ipv4_netmask
      }
      ipv4_gateway    = var.virtualmachine.web.ipv4_gateway
      dns_server_list = var.virtualmachine.web.dns_server_list
      dns_suffix_list = [var.virtualmachine.web.join_domain]
    }
  }
  scsi_controller_count = var.virtualmachine.web.scsi_controller_count
  scsi_type             = var.virtualmachine.web.scsi_type
  disk {
    size             = var.virtualmachine.web.disk_size_0
    label            = var.virtualmachine.web.disk_label_0
    eagerly_scrub    = var.virtualmachine.web.disk_eagerly_scrub_0
    thin_provisioned = var.virtualmachine.web.disk_thin_provisioned_0
    unit_number      = var.virtualmachine.web.disk_unit_number_0
  }
  tags = [
    vsphere_tag.department.id,
    data.vsphere_tag.environment-tag.id
  ]
  provisioner "local-exec" {
    command = "powershell.exe -command 'Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force'"
  }
}

resource "vsphere_virtual_machine" "web-02" {
  name             = "vm-${terraform.workspace}-${var.virtualmachine.web.b_computer_name}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus             = var.virtualmachine.web.num_cpus
  num_cores_per_socket = var.virtualmachine.web.num_cores_per_socket
  memory               = var.virtualmachine.web.memory
  folder               = vsphere_folder.web-tier-folder.path
  guest_id             = var.virtualmachine.web.guest_id
  firmware             = var.virtualmachine.web.firmware
  hardware_version     = var.virtualmachine.web.hardware_version
  network_interface {
    network_id   = data.vsphere_network.web-network.id
    adapter_type = var.virtualmachine.web.adapter_type
  }
  clone {
    template_uuid = data.vsphere_content_library_item.template.id
    timeout       = 60
    customize {
      timeout = 30
      linux_options {
        host_name = "vm-${terraform.workspace}-${var.virtualmachine.web.b_computer_name}"
        domain    = var.virtualmachine.web.join_domain
      }
      network_interface {
        ipv4_address = var.virtualmachine.web.b_ipv4_address
        ipv4_netmask = var.virtualmachine.web.ipv4_netmask
      }
      ipv4_gateway    = var.virtualmachine.web.ipv4_gateway
      dns_server_list = var.virtualmachine.web.dns_server_list
      dns_suffix_list = [var.virtualmachine.web.join_domain]
    }
  }
  scsi_controller_count = var.virtualmachine.web.scsi_controller_count
  scsi_type             = var.virtualmachine.web.scsi_type
  disk {
    size             = var.virtualmachine.web.disk_size_0
    label            = var.virtualmachine.web.disk_label_0
    eagerly_scrub    = var.virtualmachine.web.disk_eagerly_scrub_0
    thin_provisioned = var.virtualmachine.web.disk_thin_provisioned_0
    unit_number      = var.virtualmachine.web.disk_unit_number_0
  }
  tags = [
    vsphere_tag.department.id,
    data.vsphere_tag.environment-tag.id
  ]
  provisioner "local-exec" {
    command = "powershell.exe -command 'Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force'"
  }
}
