application = "varchaltf"
location = "eastus"
vm_size = "Standard_B1s"
admin_username = "terraadmin"
vnet_address_space = ["10.0.0.0/16"]
snet_address_space = ["10.0.0.0/24"]
os = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
}