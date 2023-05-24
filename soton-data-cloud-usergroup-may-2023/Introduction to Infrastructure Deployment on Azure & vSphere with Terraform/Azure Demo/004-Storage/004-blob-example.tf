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

# Create Storage Account
resource "azurerm_storage_account" "st" {
  name                = "stterraformdemo01"
  resource_group_name = data.azurerm_resource_group.rg.name

  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  allow_blob_public_access = false
  tags = {
    environment = "test"
  }
}
# Create storage container
resource "azurerm_storage_container" "sc" {
  name                  = "tempfiles"
  storage_account_name  = azurerm_storage_account.st.name
  container_access_type = "private"
}

# Create a storage blob
resource "azurerm_storage_blob" "example" {
  name                   = "vm-tf-app-1.rdp"
  storage_account_name   = azurerm_storage_account.st.name
  storage_container_name = azurerm_storage_container.sc.name
  type                   = "Block"
  access_tier            = "Hot"
  source                 = "vm-tf-app-1.rdp"
}
