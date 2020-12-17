#Azure provider
provider "azurerm" {
  version = "=2.40.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-MyFirstTerraform"
  location = "westus"
}

module "function-app" {
  source  = "InnovationNorway/function-app/azurerm"
  version = "0.1.2"

  function_app_name = "func-terrademo"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}