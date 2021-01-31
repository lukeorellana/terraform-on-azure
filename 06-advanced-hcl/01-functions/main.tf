
#Split Use Case
resource "azurerm_storage_account" "example" {
  name                = "storageaccountname"
  resource_group_name = azurerm_resource_group.example.name

  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


variable "storage_type"{
  default = "Standard_LRS"

}












resource "azurerm_storage_account" "example" {
  name                = "storageaccountname"
  resource_group_name = azurerm_resource_group.example.name

  location                 = azurerm_resource_group.example.location
  account_tier             = element(split("_","var.storage_type"), 0)
  account_replication_type = element(split("_","var.storage_type"), 1)
}




# Data File
data "template_file" "init" {
  template = "${file("./test.ps1")}"
  vars = {
    DNS_Server1 = "10.0.0.1"
    DNS_Server2 = "10.0.0.2"
  }

resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "vmterraform"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Standard_B1s"
  admin_username        = "terradamin"
  admin_password        = "P@ssw0rdP@ssw0rd"
  custom_data = data.template_file.init.rendered

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

}