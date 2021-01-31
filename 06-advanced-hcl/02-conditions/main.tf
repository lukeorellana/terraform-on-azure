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

# Location Variable
variable "location" {
    type = string
    description = "Azure location of terraform server environment"
    default = ""
}


#create resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-testcondition"
    location = var.location != "" ? var.location : "southcentralus"
                    # If True Then A Else B
}