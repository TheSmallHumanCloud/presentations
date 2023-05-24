## Define Virtual Machine
resource "vsphere_virtual_machine" "webvm" {
  name             = var.web.computer_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus                   = var.web.num_cpus
  num_cores_per_socket       = var.web.num_cores_per_socket
  memory                     = var.web.memory
  folder                     = var.web.folder
  wait_for_guest_net_timeout = var.web.wait_for_guest_net_timeout
  guest_id                   = var.web.guest_id
  firmware                   = var.web.firmware
  hardware_version           = var.web.hardware_version
  annotation                 = var.web.annotation
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = var.adapter_type
  }
  clone {
    template_uuid = data.vsphere_content_library_item.item.id
    timeout       = 60
    customize {
      timeout = 30
      windows_options {
        computer_name         = var.web.computer_name
        join_domain           = var.join_domain
        domain_admin_user     = var.domain_admin_user
        domain_admin_password = var.domain_admin_password
      }
      network_interface {
        ipv4_address = var.web.ipv4_address
        ipv4_netmask = var.web.ipv4_netmask
      }
      ipv4_gateway    = var.web.ipv4_gateway
      dns_server_list = [var.web.dns_server_list]
    }
  }
  scsi_controller_count = var.web.scsi_controller_count
  scsi_type             = var.scsi_type
  disk {
    size             = var.web.disk_size_0
    label            = var.web.disk_label_0
    eagerly_scrub    = var.web.disk_eagerly_scrub_0
    thin_provisioned = var.web.disk_thin_provisioned_0
    unit_number      = var.web.disk_unit_number_0
  }
  tags = [data.vsphere_tag.webvm.id]
}

resource "vsphere_virtual_machine" "appvm" {
  name             = var.app.computer_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus                   = var.app.num_cpus
  num_cores_per_socket       = var.app.num_cores_per_socket
  memory                     = var.app.memory
  folder                     = var.app.folder
  wait_for_guest_net_timeout = var.app.wait_for_guest_net_timeout
  guest_id                   = var.app.guest_id
  firmware                   = var.app.firmware
  hardware_version           = var.app.hardware_version
  annotation                 = var.app.annotation
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = var.adapter_type
  }
  clone {
    template_uuid = data.vsphere_content_library_item.item.id
    timeout       = 60
    customize {
      timeout = 30
      windows_options {
        computer_name         = var.app.computer_name
        join_domain           = var.join_domain
        domain_admin_user     = var.domain_admin_user
        domain_admin_password = var.domain_admin_password
      }
      network_interface {
        ipv4_address = var.app.ipv4_address
        ipv4_netmask = var.app.ipv4_netmask
      }
      ipv4_gateway    = var.app.ipv4_gateway
      dns_server_list = [var.app.dns_server_list]
    }
  }
  scsi_controller_count = var.app.scsi_controller_count
  scsi_type             = var.scsi_type
  disk {
    size             = var.app.disk_size_0
    label            = var.app.disk_label_0
    eagerly_scrub    = var.app.disk_eagerly_scrub_0
    thin_provisioned = var.app.disk_thin_provisioned_0
    unit_number      = var.app.disk_unit_number_0
  }
  tags = [data.vsphere_tag.appvm.id]
}

resource "vsphere_virtual_machine" "dbvm" {
  name             = var.db.computer_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus                   = var.db.num_cpus
  num_cores_per_socket       = var.db.num_cores_per_socket
  memory                     = var.db.memory
  folder                     = var.db.folder
  wait_for_guest_net_timeout = var.db.wait_for_guest_net_timeout
  guest_id                   = var.db.guest_id
  firmware                   = var.db.firmware
  hardware_version           = var.db.hardware_version
  annotation                 = var.db.annotation
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = var.adapter_type
  }
  clone {
    template_uuid = data.vsphere_content_library_item.item.id
    timeout       = 60
    customize {
      timeout = 30
      windows_options {
        computer_name         = var.db.computer_name
        join_domain           = var.join_domain
        domain_admin_user     = var.domain_admin_user
        domain_admin_password = var.domain_admin_password
      }
      network_interface {
        ipv4_address = var.db.ipv4_address
        ipv4_netmask = var.db.ipv4_netmask
      }
      ipv4_gateway    = var.db.ipv4_gateway
      dns_server_list = [var.db.dns_server_list]
    }
  }
  scsi_controller_count = var.db.scsi_controller_count
  scsi_type             = var.scsi_type
  disk {
    size             = var.db.disk_size_0
    label            = var.db.disk_label_0
    eagerly_scrub    = var.db.disk_eagerly_scrub_0
    thin_provisioned = var.db.disk_thin_provisioned_0
    unit_number      = var.db.disk_unit_number_0
  }
  tags = [data.vsphere_tag.dbvm.id]
}

