resource "azurerm_network_security_group" "this" {
  for_each = local.nsgs

  name                = each.value.name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "this" {
  for_each = local.nsg_rules

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this[each.value.nsg_key].name
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = local.nsgs

  network_security_group_id = azurerm_network_security_group.this[each.key].id
  subnet_id                 = azurerm_subnet.this[each.value.subnet_name].id
}

resource "azurerm_subnet_network_security_group_association" "existing" {
  for_each = local.existing_nsgs

  network_security_group_id = data.azurerm_network_security_group.this[each.value.nsg_key].id
  subnet_id                 = azurerm_subnet.this[each.value.subnet_name].id
}