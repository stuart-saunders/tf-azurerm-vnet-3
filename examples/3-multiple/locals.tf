locals {

  vnets = { for value in var.vnets :
    value.name => value
  }

}