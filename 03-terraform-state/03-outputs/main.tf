#Azure provider
provider "azurerm" {
  version = "=2.40.0"
  features {}
}

data "terraform_remote_state" "terraformdemo" {
  backend = "remote"
  config = {
    organization = "lukelabdemo"
    workspaces = {
      name = "terraformdemo"
    }
  }
}

#Create virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = "vnet-terraformtfctest"
    address_space       = ["10.0.0.0/22"]
    location            = data.terraform_remote_state.terraformdemo.outputs.rg.location
    resource_group_name = data.terraform_remote_state.terraformdemo.outputs.rg.name
}
# The same concepts apply for an Azure Storage Account backend type. To access the backend of our Azure Storage Account, we follow the same format but reference the azurerm backend type with it's required arguments:

data "terraform_remote_state" "terraformdemo" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-terraformstate"
    storage_account_name = "terrastatestorage2134"
    container_name       = "terraformdemo"
    key                  = "dev.terraform.tfstate"
  }

}

#Create virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = "vnet-terraformsatest"
    address_space       = ["10.1.0.0/22"]
    location            = data.terraform_remote_state.terraformdemo.outputs.rg.location
    resource_group_name = data.terraform_remote_state.terraformdemo.outputs.rg.name
}