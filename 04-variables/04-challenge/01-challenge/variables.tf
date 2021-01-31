variable "application" {
  type        = string
  description = "Application name"
}

variable "location" {
  type        = string
  description = "Azure location of network components"
  default     = "westus2"
}

variable "vnet_address_space" {
  type        = list(any)
  description = "Address space for Virtual Network"
  default     = ["10.0.0.0/16"]
}

variable "snet_address_space" {
  type        = list(any)
  description = "Address space for Subnet"
  default     = ["10.0.0.0/24"]
}