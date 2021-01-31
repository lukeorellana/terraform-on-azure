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

variable "inbound_rules" {
  type = map
  description = "A map of allowed inbound ports and their priority value"
  default = {
    101 = 3389
    102 = 22
    103 = 443

  }
}

# Resource Group
resource "azurerm_resource_group" "rg" {

  name     = "rg-mytesourcegroup"
  location = "West US 2"
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-mysecuritygroup"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# NSG Rule
resource "azurerm_network_security_rule" "nsg_rule" {
  for_each = var.inbound_rules
  name                        = "port_${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}