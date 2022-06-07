###create virtual network
resource "azurerm_virtual_network" "myvnet" {
  name                = "myvnet-1"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}
#we need to create a subnet
resource "azurerm_subnet" "mysubnet" {
  name                 = "mysubnet-1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name #once the subnet is created it will will attached with your vnet
  address_prefixes     = ["10.0.2.0/24"]
}
#public ip we have create inside our rg but not yet attached with anything
resource "azurerm_public_ip" "mypublicip" {
  name                = "mypublicip-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static" ###public ip can be static or dynamic in nature

  tags = {
    environment = "Production"
  }
}
#once you create a public you need to first create an nic card then attach the same with your nic card
#we will create a nic and attach subnet and piublci ip
resource "azurerm_network_interface" "myvmnic1" {
  name = "vm1-nic"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id =  azurerm_public_ip.mypublicip.id
  }
}