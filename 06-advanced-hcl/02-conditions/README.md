# Conditions

```condition ? true : false
```

```

variable "vm_location" {
    type = string
    description = "Azure location of terraform server environment"
    default = ""

}

resource "azurerm_virtual_machine" "main" {
  name                  = "MyVMName"
  location              = var.vm_location != "" ? var.vm_location : azurerm_resource_group.main.location
  ...

```


### For Expressions


```
data "azurerm_virtual_network" "example" {
  name                = "LukeLab-NC-Prod-Vnet"
  resource_group_name = "NetworkingTest-RG"
}

output "subnets" {
  value = [for s in data.azurerm_virtual_network.example.subnets : lower(s)]
}
```

```
data "azurerm_virtual_network" "example" {
  name                = "LukeLab-NC-Prod-Vnet"
  resource_group_name = "NetworkingTest-RG"
}

output "subnets" {
  value = [for s in data.azurerm_virtual_network.example.subnets : s if length(regexall("LukeApp[2-4]-NC-Prod-Subnet", s)) > 0]

}
```

Splat

```
data.azurerm_virtual_network.example[*].subnets
```


