resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_resource_group" "existing" {
  name     = "existing-rg"
  location = var.resource_group_location
}

module "existing_nsg" {
  source   = "./modules/nsg"
  for_each = local.nsgs

  name = each.key
  location = azurerm_resource_group.existing.location
  resource_group_name = azurerm_resource_group.existing.name

  rules = each.value.rules
}

module "existing_route_table" {
  source   = "./modules/route-table"
  for_each = local.route_tables

  name = each.key
  location = azurerm_resource_group.existing.location
  resource_group_name = azurerm_resource_group.existing.name

  routes = each.value.routes
}

module "vnet" {
  source   = "../../"
  for_each = { for vnet in var.vnets : vnet.name => vnet }

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location

  vnet = each.value

  depends_on = [    
    module.existing_nsg,
    module.existing_route_table
  ]
}