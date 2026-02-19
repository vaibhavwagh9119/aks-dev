
output "subnet_id" {
  value = azurerm_subnet.aks.id
}

output "vnet_id" {
  value = azurem_virtual_network.vnet.id
}

output "private_endpoint_subnet_id" {
  value = azurerm_subnet.private_endpoint.id
}
