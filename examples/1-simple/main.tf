resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "vnet" {
  source = "../../"
  for_each = { for vnet in var.vnets : vnet.name => vnet }

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location

  vnet = each.value

  depends_on = [
    azurerm_resource_group.this
  ]
}