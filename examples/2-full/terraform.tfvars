resource_group_name     = "rg-vnet-module-test"
resource_group_location = "uksouth"

vnets = [
  {
    name = "example2-vnet0"
    address_space = ["10.0.0.0/16"]

    subnets = [
      {
        name = "delegated-subnet"
        address_prefixes = ["10.0.0.0/24"]
        delegation = {
          name = "container-instance-delegation"
          service_delegation = {
            name = "Microsoft.ContainerInstance/containerGroups"
            actions = [
              "Microsoft.Network/virtualNetworks/subnets/join/action",
              "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
            ]
          }
        }
      },
      {
        name = "subnet-with-existing-nsg"
        address_prefixes = ["10.0.1.0/24"]
        
        existing_nsgs = [
          {
            name = "existing_nsg_0"
            resource_group_name = "existing-rg"
          }
        ]
      },
      {
        name = "subnet-with-route-table"
        address_prefixes = ["10.0.2.0/24"]
        route_tables = [
          {
            name = "no-internet-rt"
            routes = [
              {
                name = "no-internet-route"
                address_prefix = "0.0.0.0/0"
                next_hop_type  = "None"
              }
            ]
          }
        ]
      },
      {
        name = "subnet-with-existing-route-table"
        address_prefixes = ["10.0.3.0/24"]
        
        existing_route_tables = [
          {
            name = "existing_rt_0"
            resource_group_name = "existing-rg"
          }
        ]
      },
      {
        name = "subnet-with-service-endpoint"
        address_prefixes  = ["10.0.4.0/24"]
        service_endpoints = ["Microsoft.Storage"]  
      }
    ]
  },
  {
    name = "example2-vnet1"
    address_space = ["10.1.0.0/16"]

    subnets = [
      {
        name = "subnet-with-nsg"
        address_prefixes = ["10.1.1.0/24"]
        nsgs = [
          {
            name = "nsg0"
            rules = [
              {
                name                       = "winrm"
                priority                   = "1001"
                direction                  = "Inbound"
                access                     = "Allow"
                protocol                   = "Tcp"
                source_port_range          = "*"
                destination_port_range     = "5985"
                source_address_prefix      = "VirtualNetwork"
                destination_address_prefix = "VirtualNetwork"
              },
              {
                name                       = "web-inbound-http"
                priority                   = "1002"
                direction                  = "Inbound"
                access                     = "Allow"
                protocol                   = "Tcp"
                source_port_range          = "*"
                destination_port_range     = "80"
                source_address_prefix      = "*"
                destination_address_prefix = "VirtualNetwork"
              }
            ]
          }
        ]
      }
    ]
  }
]

nsgs = [
  {
    name = "existing_nsg_0"
    rules = [
      {
        name                       = "winrm"
        priority                   = "1001"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "5985"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "web-inbound-http"
        priority                   = "1002"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      }
    ]
  }
]

route_tables = [
  {
    name = "existing_rt_0"
    routes = [
      {
        name = "no-internet-route"
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "None"
      }
    ]
  }
]