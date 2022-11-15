##Other Variables
application_name     = "application-abc"
department           = "central-services"
category_environment = "environment"
category_department  = "department"
environment_tags = {
  dev = "development"
  prd = "production"
}
department_tags = ["finance", "r&d", "sales"]

#Network Variables
t1_name      = "lab-t1"
overlay_name = "sfo-m01-tz-overlay01"
nsxt_networks = {
  prod = {
    web = {
      display_name = "app-abc-web-network"
      description  = "Segment created by Terraform"
      cidr         = "10.200.1.1/24"
    }
    app = {
      display_name = "app-abc-app-network"
      description  = "Segment created by Terraform"
      cidr         = "10.200.2.1/24"
    }
    db = {
      display_name = "app-abc-db-network"
      description  = "Segment created by Terraform"
      cidr         = "10.200.3.1/24"
    }
  }
  dev = {
    web = {
      display_name = "app-abc-web-network"
      description  = "Segment created by Terraform"
      cidr         = "10.201.1.1/24"
    }
    app = {
      display_name = "app-abc-app-network"
      description  = "Segment created by Terraform"
      cidr         = "10.201.2.1/24"
    }
    db = {
      display_name = "app-abc-db-network"
      description  = "Segment created by Terraform"
      cidr         = "10.201.3.1/24"
    }
  }
}
vsphere_port_group = {
  web = "web-network"
  app = "app-network"
  db  = "db-network"
}
load_balancer = {
  prod = {
    ip = "10.200.1.50"
  }
  dev = {
    ip = "10.201.1.50"
  }
}
lb_app_profile = "default-http-lb-app-profile"

#VM Variables
vsphere_template = "PhotonOS3.0_OVA"
virtualmachine = {
  web = {
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
  app = {
    #Node1
    a_computer_name = "app-01"
    a_ipv4_address  = "10.200.2.10"
    #Node2
    b_computer_name = "app-02"
    b_ipv4_address  = "10.200.2.11"
    #Common
    num_cpus                = "1"
    num_cores_per_socket    = "1"
    memory                  = "2048"
    folder                  = "app"
    guest_id                = "vmwarePhoton64Guest"
    firmware                = "efi"
    hardware_version        = 19
    annotation              = "Built using Terraform"
    adapter_type            = "vmxnet3"
    ipv4_netmask            = 24
    ipv4_gateway            = "10.200.2.1"
    dns_server_list         = ["192.168.10.1"]
    join_domain             = "corp.local"
    scsi_controller_count   = 1
    scsi_type               = "pvscsi"
    disk_size_0             = 24
    disk_label_0            = "Disk0.vmdk"
    disk_eagerly_scrub_0    = false
    disk_thin_provisioned_0 = true
    disk_unit_number_0      = 0
  }
  db = {
    #Node1
    a_computer_name = "db-01"
    a_ipv4_address  = "10.200.3.10"
    #Node2
    b_computer_name = "db-02"
    b_ipv4_address  = "10.200.3.11"
    #Common
    num_cpus                = "1"
    num_cores_per_socket    = "1"
    memory                  = "8192"
    folder                  = "db"
    guest_id                = "vmwarePhoton64Guest"
    firmware                = "efi"
    hardware_version        = 19
    annotation              = "Built using Terraform"
    adapter_type            = "vmxnet3"
    ipv4_netmask            = 24
    ipv4_gateway            = "10.200.3.1"
    dns_server_list         = ["192.168.10.1"]
    join_domain             = "corp.local"
    scsi_controller_count   = 1
    scsi_type               = "pvscsi"
    disk_size_0             = 24
    disk_label_0            = "Disk0.vmdk"
    disk_eagerly_scrub_0    = false
    disk_thin_provisioned_0 = true
    disk_unit_number_0      = 0
  }

}
