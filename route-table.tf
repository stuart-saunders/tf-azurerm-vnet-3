resource "azurerm_route_table" "this" {
  for_each = local.route_tables

  name                          = each.value.name
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = each.value.disable_bgp_route_propagation

  tags = var.tags
}

resource "azurerm_route" "this" {
  for_each = local.routes

  name                = each.value.name
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.this[each.value.route_table_key].name
  address_prefix      = each.value.address_prefix
  next_hop_type       = each.value.next_hop_type
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each = local.route_tables

  route_table_id = azurerm_route_table.this[each.key].id
  subnet_id      = azurerm_subnet.this[each.value.subnet_name].id
}

resource "azurerm_subnet_route_table_association" "existing" {
  for_each = local.existing_route_tables

  route_table_id = data.azurerm_route_table.this[each.value.table_key].id
  subnet_id      = azurerm_subnet.this[each.value.subnet_name].id
}

