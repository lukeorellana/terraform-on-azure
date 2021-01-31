# Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

# Create NIC
resource "azurerm_network_interface" "nic" {
  name                      = "nic-${var.servername}-001 "
  location                  = var.location
  resource_group_name       = var.resource_group_name

  ip_configuration {
    name                          = "niccfg-${var.servername}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "dynamic"
  }
}


# Create virtual machine
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.servername
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = lookup(var.storage_account_type, var.location, "Standard_LRS")
  }

  source_image_reference {
    publisher = var.os.publisher
    offer     = var.os.offer
    sku       = var.os.sku
    version   = var.os.version
  }

}