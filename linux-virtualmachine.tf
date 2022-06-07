resource "azurerm_linux_virtual_machine" "mylinuxvm" {
    count = 2
  name                = "mylinuxvm${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  computer_name = "devlinux-vm1-${count-index}"
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  network_interface_ids = [
    element(azurerm_network_interface.myvmnic1[*].id,count.index)
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name = "osdisk${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
}