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

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform-demo"
  location = "UK South"
  tags = {
    environment  = "Production"
    ResourceType = "Manangement"
    Status       = "live"
  }
}

# Create a resource group
resource "azurerm_resource_group" "rg2" {
  name     = "rg-terraform-demo2"
  location = "UK South"
  tags = {
    environment  = "Dev"
    ResourceType = "Manangement"
    Status       = "live"
  }
}
