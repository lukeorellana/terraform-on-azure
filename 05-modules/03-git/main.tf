provider "azurerm" {
  version = "1.38.0"
}

#create resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-MyFirstTerraform"
    location = "westus"
}

#Git Azure DevOps
#Create Storage Account
module "storage_account" {
  source    = "git::https://allanore@dev.azure.com/allanore/TerraformModulesExample/_git/TerraformModulesExample?ref=v0.1"

  saname    = "tfdemosa23432"
  rgname    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}

#Git SSH Azure DevOps
#Create Storage Account
module "storage_account" {
  source    = "github.com/allanore/TerraformModulesExample"

  saname    = "tfdemosa23432"
  rgname    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}

#Github
