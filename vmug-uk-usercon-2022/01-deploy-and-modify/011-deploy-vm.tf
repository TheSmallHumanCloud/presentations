#Providers
provider "vsphere" {
  vsphere_server       = "vc-l-01a.corp.local"
  user                 = "administrator@vsphere.local"
  password             = "VMware1!"
  allow_unverified_ssl = "true"
}

#Data
#Datacenter
data "vsphere_datacenter" "datacenter" {
  name = "sfo-m01-dc01"
}
#Datastore
data "vsphere_datastore" "datastore" {
  name          = "sfo-m01-cl01-ds-vsan01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
#Cluster
data "vsphere_compute_cluster" "cluster" {
  name          = "sfo-m01-cl01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
#PortGroups
data "vsphere_network" "network" {
  name          = "sfo01-m01-cl01-vds01-pg-web"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
#Content Library
data "vsphere_content_library" "library" {
  name = "Subscribed"
}
#Template
data "vsphere_content_library_item" "template" {
  name       = "smallVM"
  library_id = data.vsphere_content_library.library.id
  type       = "OVF"
}

#Resources
resource "vsphere_virtual_machine" "vm" {
  name             = "vm-01"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus             = "1"
  num_cores_per_socket = "1"
  memory               = "2"
  #memory               = "4"
  guest_id         = "otherLinuxGuest"
  firmware         = "efi"
  hardware_version = 19
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }
  clone {
    template_uuid = data.vsphere_content_library_item.template.id
    timeout       = 60
    customize {
      timeout = 30
      linux_options {
        host_name = "vm-01"
        domain    = "corp.local"
      }
      network_interface {
        ipv4_address = "192.168.100.10"
        ipv4_netmask = 24
      }
      ipv4_gateway    = "192.168.100.1"
      dns_server_list = ["192.168.10.1"]
      dns_suffix_list = ["corp.local"]
    }
  }
  scsi_controller_count = 1
  scsi_type             = "pvscsi"
  disk {
    size             = 25
    label            = "Disk0.vmdk"
    eagerly_scrub    = false
    thin_provisioned = true
    unit_number      = 0
  }
}
