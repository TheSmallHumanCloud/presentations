terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.57.0"
    }
    vsphere = {
      source = "hashicorp/vsphere"
    }
  }
}
# Terraform Providers
provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
  }
}
provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_user
  password             = var.vsphere_password
  allow_unverified_ssl = true
}

# Azure resources
# Create an resource group
resource "azurerm_resource_group" "rg1" {
  name     = "rg-tf_app_2"
  location = var.azure_location
  tags = {
    environment  = "Production"
    ResourceType = "Manangement"
    Status       = "Operational"
  }
}
# Get an existing resource group
data "azurerm_resource_group" "rg" {
  name = "rg-terraform-demo"
}
# get existing virtual network
data "azurerm_virtual_network" "vnet" {
  name                = "vnet-10.0.0.0-16"
  resource_group_name = "rg-terraform-demo"
}

# Create a virtual subnet
resource "azurerm_subnet" "snet" {
  name                 = "snet-10.0.6.0-24"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.6.0/24"]
}

# Create a network security group
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-tf-app-1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  security_rule {
    name                       = "tf_app_2_inbound_rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Development"
    application = "tf_app_2"
  }
}

# Associate nsg with subnet
resource "azurerm_subnet_network_security_group_association" "nsgasso" {
  subnet_id                 = azurerm_subnet.snet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create a network interface for the vm
resource "azurerm_network_interface" "netint" {
  name                = "nic-tf_app_2"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "snet-10.6.0.0-24"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create vm
resource "azurerm_windows_virtual_machine" "vm" {
  name                     = "vm-tf-app-2"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  size                     = "Standard_B1s"
  admin_username           = var.azure_username
  admin_password           = var.azure_password
  enable_automatic_updates = true
  license_type             = "Windows_Server"
  network_interface_ids = [
    azurerm_network_interface.netint.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  tags = {
    environment  = "development"
    ResourceType = "demo_vm"
    Status       = "operational"
  }
}

# Create a vm managed disk
resource "azurerm_managed_disk" "mandisk" {
  name                 = "vm-tf_app_2-disk1"
  location             = azurerm_resource_group.rg1.location
  resource_group_name  = azurerm_resource_group.rg1.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

# Associate the managed disk with the vm
resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  managed_disk_id    = azurerm_managed_disk.mandisk.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  lun                = "10"
  caching            = "ReadWrite"
}


# vSphere resources
## Data Gathering
data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_content_library" "library" {
  name = var.vsphere_library
}
data "vsphere_content_library_item" "item" {
  name       = var.vsphere_template
  library_id = data.vsphere_content_library.library.id
  type       = "OVF"
}
## Define Virtual Machine
resource "vsphere_virtual_machine" "vm" {
  name             = var.computer_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus                   = var.num_cpus
  num_cores_per_socket       = var.num_cores_per_socket
  memory                     = var.memory
  folder                     = var.folder
  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
  guest_id                   = var.guest_id
  firmware                   = var.firmware
  nested_hv_enabled          = var.nested_hv_enabled
  hardware_version           = var.hardware_version
  annotation                 = var.annotation
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = var.adapter_type
  }
  clone {
    template_uuid = data.vsphere_content_library_item.item.id
    timeout       = 60
    customize {
      timeout = 30
      linux_options {
        host_name = var.computer_name
        domain    = var.join_domain
      }
      network_interface {
        ipv4_address = var.ipv4_address
        ipv4_netmask = var.ipv4_netmask
      }
      ipv4_gateway    = var.ipv4_gateway
      dns_server_list = var.dns_server_list
      dns_suffix_list = [var.join_domain]
    }
  }
  scsi_controller_count = var.scsi_controller_count
  scsi_type             = var.scsi_type
  disk {
    size             = var.disk_size_0
    label            = var.disk_label_0
    eagerly_scrub    = var.disk_eagerly_scrub_0
    thin_provisioned = var.disk_thin_provisioned_0
    unit_number      = var.disk_unit_number_0
  }

}
