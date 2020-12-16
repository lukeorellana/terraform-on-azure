# Functions
Terraform console

```
> lower("TFStoragesta")
tfstoragesta
```

```
> max(32,64,99)
```
```
> min (32,128,1024)
```


```
> split("_","Standard_LRS")
[
  "Standard",
  "LRS",
]
```
Can be used with storage account:
```
resource "azurerm_storage_account" "example" {
  name                = "storageaccountname"
  resource_group_name = azurerm_resource_group.example.name

  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

```
> element(split("_","Standard_LRS"), 0)
Standard

```
```
resource "azurerm_storage_account" "example" {
  name                = "storageaccountname"
  resource_group_name = azurerm_resource_group.example.name

  location                 = azurerm_resource_group.example.location
  account_tier             = element(split("_","var.storage_type"), 0)
  account_replication_type = element(split("_","var.storage_type"), 1)
}

```

```
coalesce("40", "50", "20")
```


```
> length(["32GB", "64GB"])
2
```

```
> setproduct(["development", "staging", "production"], ["EastUS", "WestUS"])
[
  [
    "development",
    "EastUS",
  ],
  [
    "development",
    "WestUS",
  ],
  [
    "staging",
    "EastUS",
  ],
  [
    "staging",
    "WestUS",
  ],
  [
    "production",
    "EastUS",
  ],
  [
    "production",
    "WestUS",
  ],
]
```

```
> file("${path.module}/test.ps1")
#This is an empty PS1
```
```
data "template_file" "init" {
  template = "${file("./test.ps1")}"
  vars = {
    DNS_Server1 = "10.0.0.1"
    DNS_Server2 = "10.0.0.2"
  }

resource "azurerm_virtual_machine" "main" {
...
  os_profile {
      computer_name  = "myserver"
      admin_username = "adminuser"
      admin_password = "badpassword123"
      custom_data = data.template_file.init.rendered
    }
...
}
```




