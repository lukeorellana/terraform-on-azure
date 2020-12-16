provider "azurerm" {
  version = "1.38.0"
}

#create resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-MyFirstTerraform"
    location = "westus"
}

#Create Storage Account
module "storage_account" {
  source    = "./modules/storage-account"

  saname    = "statfdemosa234"
  rgname    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}

#Create Storage Account
module "storage_account2" {
  source    = "./modules/storage-account"

  saname    = "statfdemosa241"
  rgname    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}