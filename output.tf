output "resource_group_name" {
  Description = "name of the resource group"
  value = azurerm_resource_group.rg.name
}
output "public_ip_address" {
  Description = "public ip of the instance"
  value = azurerm_linux_virtual_machine.mylinuxvm.public_ip_addresses
}