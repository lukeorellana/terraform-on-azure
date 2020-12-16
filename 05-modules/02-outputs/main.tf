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

resource "azurerm_key_vault_secret" "stasecret" {
  name         = "statfdemosa234-secret"
  value        = module.storage_account.primary_key
  key_vault_id = azurerm_key_vault.kv.id

}