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

#Create resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-myapp"
    location = "westus"
}

#Create Storage Account
module "storage_account1" {
  source    = "./modules/storage-account"

  saname    = "statfdemosa24234"
  rgname    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}


#Create Storage Account
module "storage_account2" {
  source    = "./modules/storage-account"

  saname    = "statfdemosa23434"
  rgname    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}