variable "name" {
  type = string
  description = "The name of the Network Security Group"
}

variable "resource_group_name" {
  type = string
  description = "The name of the Resource Group in which to create the NSG"
}

variable "location" {
  type = string
  description = "The Azure location where the NSG should exist"  
}

variable "rules" {
  type = list(object({
    name = string
    priority = string
    direction = string
    access = string
    protocol = string
    source_port_range = string
    destination_port_range = string
    source_address_prefix = string
    destination_address_prefix = string
  }))
  description = "The security rules that apply to this NSG"
}