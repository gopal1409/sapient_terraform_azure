###create virtual network
resource "azurerm_virtual_network" "myvnet" {
  name = "myvnet-1"
  address_space = [ "10.0.0.0/16" ]
  resource_group_name = azurerm_resource_group.rg.name
  location =  azurerm_resource_group.rg.location
}
#subnet
#public ip
#nic card