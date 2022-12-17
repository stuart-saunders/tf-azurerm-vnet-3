output "virtual_network_id" {
  value = [for vnet in module.vnet :
    vnet.virtual_network_id
  ]
}

output "subnets" {
  value = [for vnet in module.vnet :
    { for subnet in vnet.subnets :
      subnet.name => {
        id   = subnet.id
        name = subnet.name
      }
    }
  ]
}