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

# Get an existing resource group
data "azurerm_resource_group" "rg" {
  name = "rg-terraform-demo"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-demo-network"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  address_space       = ["10.1.0.0/16"]
  tags = {
    environment  = "production"
    ResourceType = "root-virtual network"
    Status       = "operational"
  }
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "snet" {
  name                 = "snet-10.1.2.0-24"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.2.0/24"]
  depends_on           = [azurerm_virtual_network.vnet]
}
