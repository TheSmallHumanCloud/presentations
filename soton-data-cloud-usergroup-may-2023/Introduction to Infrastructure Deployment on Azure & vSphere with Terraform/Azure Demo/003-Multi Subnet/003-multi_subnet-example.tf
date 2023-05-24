terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.57.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Get a virtual network within the resource group
data "azurerm_virtual_network" "vnet" {
  name                = "vnet-demo-network"
  resource_group_name = "rg-terraform-demo"
}

# Get an existing resource group
data "azurerm_resource_group" "rg" {
  name = "rg-terraform-demo"
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "snet3" {
  name                 = lower("snet-10.1.3.0-24")
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.3.0/24"]
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "snet4" {
  name                 = lower("snet-10.1.4.0-24")
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.4.0/24"]
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "snet5" {
  name                 = lower("SNET-10.1.5.0-24")
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.5.0/24"]
}
