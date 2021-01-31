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


data "azurerm_virtual_network" "example" {
  name                = "vnet-lukelab-nc-prod-01"
  resource_group_name = "rg-tfforexpressions"
}









# output "subnets" {
#   value = [for s in data.azurerm_virtual_network.example.subnets : lower(s)]
# }




# output "subnets" {
#   value = {for s in data.azurerm_virtual_network.example.subnets : s => lower(s)}
# }





# output "subnets" {
#   value = [for s in data.azurerm_virtual_network.example.subnets : s if length(regexall("snet-LukeLab-0[2-4]", s)) > 0]

# }





# output "subnets" {
#   value = data.azurerm_virtual_network.example[*].subnets[0]

# }

