output "virtual_network_id" {
  value = [ for v in module.vnet :
    {
      id = v.virtual_network_id
    }
  ]
}