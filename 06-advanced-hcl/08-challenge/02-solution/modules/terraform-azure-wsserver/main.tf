# Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

#Collect powershell script and input variables
data "template_file" "init" {
  template = file("${path.module}/post-deploy.ps1")
  vars = {
    webservername = var.servername
  }
}


# Create public IP
resource "azurerm_public_ip" "publicip" {
  name                = "pip-${var.servername}-dev-${var.location}-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}


# Create NIC
resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.servername}-001"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "niccfg-${var.servername}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }

}

#Network interface Association
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.nsg_id
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
  custom_data           = base64encode(data.template_file.init.rendered)

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


#Azure Custom Script Extension for Script Deployment
resource "azurerm_virtual_machine_extension" "script" {
  name                 = "${var.servername}-script-ext"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  # CustomVMExtension Documetnation: https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows

  settings = <<SETTINGS
    {
      "commandToExecute": "rename  C:\\AzureData\\CustomData.bin  postdeploy.ps1 & powershell -ExecutionPolicy Unrestricted -File C:\\AzureData\\postdeploy.ps1"

    }
SETTINGS

  lifecycle {
    ignore_changes = [
      settings,
    ]
  }

}