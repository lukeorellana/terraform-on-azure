# Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

#Azure provider
provider "azurerm" {
  features {}
}

#Data Source for Shared Network Terraform State
data "terraform_remote_state" "terraformdemo" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-terraformstate"
    storage_account_name = "terrastatestorage2188"
    container_name       = "terraformdemo"
    key                  = "dev.terraform.tfstate"
  }

}

# Create subnet
resource "azurerm_subnet" "app_subnet" {
  name                 = "snet-dev-001"
  resource_group_name  = data.terraform_remote_state.terraformdemo.outputs.rg_name
  virtual_network_name = data.terraform_remote_state.terraformdemo.outputs.vnet_name
  address_prefixes     = ["10.0.2.0/24"]
}

