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

# Boot Diagnostics Variables
variable "bootdiag_storage" {
  type = bool
  default = true
}

# Resource Group
resource "azurerm_resource_group" "rg" {

  name     = "rg-MyResourceGroup"
  location = "West US 2"
}

# Storage Account
resource "azurerm_storage_account" "bootdiag" {
  count = var.bootdiag_storage ? 1 : 0

  name                     = "myterraformvmsadiag"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}