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
 #adding explicitly dependecy to have this resource created only after virtual netowrk and subnet resources are created
 count = 2 #coun is simlar to for loop inside a resource if you put count =2 it will create the resource two times
 depends_on = [
   azurerm_virtual_network.myvnet,
   azurerm_subnet.mysubnet
 ]
  name                = "mypublicip-${count.index}" #once the resource get created i want a numeber in the name convetion
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static" ###public ip can be static or dynamic in nature
  domain_name_label = "app1-vm${count.index}-${random_string.myrandom..id}"
  tags = {
    environment = "Production"
  }
}
#once you create a public you need to first create an nic card then attach the same with your nic card
#we will create a nic and attach subnet and piublci ip
resource "azurerm_network_interface" "myvmnic1" {
  count = 2
  name = "vmnic-${count.index}"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id =  element(azurerm_public_ip.mypublicip[*].id,count.index)
  }
}
#we want the virtual network will be created first then only create the subnet and public ip