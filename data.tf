data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_network_security_group" "this" {
  for_each = local.existing_nsgs

  name                = each.value.name
  resource_group_name = each.value.resource_group_name == null ? var.resource_group_name : each.value.resource_group_name
}

data "azurerm_route_table" "this" {
  for_each = local.existing_route_tables

  name                = each.value.name
  resource_group_name = each.value.resource_group_name == null ? var.resource_group_name : each.value.resource_group_name
}