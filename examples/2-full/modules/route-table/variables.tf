variable "name" {
  type = string
  description = "The name of the Route Table"
}

variable "resource_group_name" {
  type = string
  description = "The name of the Resource Group in which to create the Route Table"
}

variable "location" {
  type = string
  description = "The Azure location where the Route Table should exist"  
}

variable "disable_bgp_route_propagation" {
  type = bool
  description = ""
  default = false
}

variable "routes" {
  type = list(object({
    name = string
    address_prefix = string
    next_hop_type = string
  }))
  description = "The routes that belong to the Route Table"
}