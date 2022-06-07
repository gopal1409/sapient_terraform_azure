output "resource_group_name" {
  description = "name of the resource group"
  value = azurerm_resource_group.rg.name
}
output "public_ip_address" {
  description = "public ip of the instance"
  value = azurerm_linux_virtual_machine.mylinuxvm.public_ip_addresses
}