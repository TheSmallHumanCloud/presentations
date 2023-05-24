terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.57.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
}

# Get a virtual network within the resource group
data "azurerm_virtual_network" "vnet" {
  name                = "vnet-10.0.0.0-16"
  resource_group_name = "rg-terraform-demo"
}

# Get an existing resource group
data "azurerm_resource_group" "rg" {
  name = "rg-terraform-demo"
}

# Create an mssql server
resource "azurerm_mssql_server" "sqlser" {
  name                         = "sqlsvr-terraform1"
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = data.azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
  tags = {
    environment = "test"
  }
}

# Create an mssql database
resource "azurerm_mssql_database" "sqldb" {
  name                 = "db-terraform-demo"
  server_id            = azurerm_mssql_server.sqlser.id
  collation            = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb          = 1
  sku_name             = "B"
  geo_backup_enabled   = false
  storage_account_type = "LRS"
  tags = {
    environment = "test"
  }
}
