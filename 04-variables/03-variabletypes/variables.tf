variable "location" {
    type = string
    description = "Location of azure resources"
    default = "westus2"
    
}

variable "password" {
    type = string
    description = "Local admin password"
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

variable "os" {
    description = "OS image to deploy"
    type = object({
        publisher = string
        offer = string
        sku = string
        version = string
  })
} 