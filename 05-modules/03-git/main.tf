#Azure provider
provider "azurerm" {
  version = "=2.40.0"
  features {}
}

#create resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-MyFirstTerraform"
    location = "westus"
}

#Git Azure DevOps
module "storage_account" {
  source    = "git::https://allanore@dev.azure.com/allanore/TerraformModulesExample/_git/TerraformModulesExample?ref=v0.1"

  saname    = "tfdemosa23432"
  rgname    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}

#GitHub
module "storage_account" {
  source    = "github.com/allanore/TerraformModulesExample"

  saname    = "tfdemosa23432"
  rgname    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}

#Terraform registry
module "function-app" {
  source  = "InnovationNorway/function-app/azurerm"
  version = "0.1.2"

  function_app_name = "func-terrademo"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}