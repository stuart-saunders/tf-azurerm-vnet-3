locals {

  vnets = { for vnet in var.vnets :
    vnet.name => vnet
  }

  nsgs = { for nsg in var.nsgs :
    nsg.name => nsg
  }

  route_tables = { for table in var.route_tables :
    table.name => table
  }

}