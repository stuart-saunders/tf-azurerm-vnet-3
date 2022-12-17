output "virtual_network_id" {
  description = "The Id of the Virtual Network created"
  value       = azurerm_virtual_network.this.id
}

output "subnets" {
  description = "The details of the subnets created"
  value       = azurerm_subnet.this
}

# output "nsgs" {
#   description = "The details of the NSGs created"
#   value       = azurerm_network_security_group.this
# }

# output "route_tables" {
#   description = "The details of the Route Tables created"
#   value       = azurerm_network_security_group.this
# }