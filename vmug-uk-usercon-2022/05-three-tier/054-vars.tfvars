##Other Variables
application_name = "application-abc"

#Network Variables
vsphere_port_group = {
  web = "web-network"
  app = "app-network"
  db  = "db-network"
}

#VM Variables
vsphere_template = "PhotonOS3.0_OVA"
virtualmachine = {
  web01 = {
    #Node1
    a_computer_name = "web-01"
    a_ipv4_address  = "10.200.1.10"
    #Node2
    b_computer_name = "web-02"
    b_ipv4_address  = "10.200.1.11"
    #Common
    num_cpus                = "1"
    num_cores_per_socket    = "1"
    memory                  = "1024"
    folder                  = "web"
    guest_id                = "vmwarePhoton64Guest"
    firmware                = "efi"
    hardware_version        = 19
    annotation              = "Built using Terraform"
    adapter_type            = "vmxnet3"
    ipv4_netmask            = 24
    ipv4_gateway            = "10.200.1.1"
    dns_server_list         = ["192.168.10.1"]
    join_domain             = "corp.local"
    scsi_controller_count   = 1
    scsi_type               = "pvscsi"
    disk_size_0             = 16
    disk_label_0            = "Disk0.vmdk"
    disk_eagerly_scrub_0    = false
    disk_thin_provisioned_0 = true
    disk_unit_number_0      = 0
  }
}
