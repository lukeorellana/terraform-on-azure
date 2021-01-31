variable "servername" {
  type        = string
  description = "Name of the Virtual Machine"
}

variable "location" {
  type        = string
  description = "Azure location of network components"
  default     = "westus2"
}

variable "resource_group_name" {
    type = string
    description = "Name of the Resource Group to deploy the Virtual Machine"
}


variable "admin_username" {
    type = string
    description = "Administrator username for server"
}

variable "admin_password" {
    type = string
    description = "Administrator password for server"
    sensitive   = true
}


variable "storage_account_type" { 
    type = map
    description = "Disk type Premium in Primary location Standard in DR location"

    default = {
        westus2 = "Premium_LRS"
        eastus = "Standard_LRS"
    }
}


variable "vm_size" {
    type = string
    description = "Size of VM"
    default = "Standard_B1s"
}

variable "os" {
    description = "OS image to deploy"
    type = object({
        publisher = string
        offer = string
        sku = string
        version = string
  })
}   

variable "subnet_id" {
    type = string
    description = "ID of the subnet to assign to the Network Interface resource"
}