# Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
   backend "azurerm" {
    resource_group_name  = "rg-terraformstate"
    storage_account_name = "terrastatestorage2188"
    container_name       = "terraformdemo"
    key                  = "modchallenge.terraform.tfstate"
  }
}

#Azure provider
provider "azurerm" {
  features {}
}

#create resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-modchallenge"
  location = "westus2"
}

#Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-modchallenge-${azurerm_resource_group.rg.location}-001"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-modchallenge-${azurerm_resource_group.rg.location}-001"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

module "server" {
  source = "./modules/terraform-azure-server"

  subnet_id = azurerm_subnet.subnet.id
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location

  servername = "server1"
  vm_size = "Standard_B1s"
  admin_username = "terraadmin"
  admin_password = "P@ssw0rdP@ssw0rd"
  os = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

}