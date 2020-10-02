provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name = "my-first-terraform-rg"
  location = "Central India"
}

resource "azurerm_virtual_network" "myvnet" {
  name = "my-vnet"
  address_space = ["10.0.0.0/16"]
  location = "Central India"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "frontendsubnet" {
  name = "frontendSubnet"
  resource_group_name =  azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefix = "10.0.1.0/24"
}

resource "azurerm_public_ip" "myvm1publicip" {
  name = "pip1"
  location = "Central India"
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method = "Dynamic"
  sku = "Basic"
}

resource "azurerm_network_interface" "myvm1nic" {
  name = "myvm1-nic"
  location = "Central India"
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name = "ipconfig1"
    subnet_id = azurerm_subnet.frontendsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.myvm1publicip.id
  }
}

resource "azurerm_network_interface" "myvm1nic1" {
  name = "myvm1-nic1"
  location = "Central India"
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name = "ipconfig1"
    subnet_id = azurerm_subnet.frontendsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "myNetworkSecurityGroup"
    location            = "Central India"
    resource_group_name = azurerm_resource_group.rg.name
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}
# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "sg_associate1" {
    network_interface_id      = azurerm_network_interface.myvm1nic.id
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}

resource "azurerm_network_interface_security_group_association" "sg_associate2" {
    network_interface_id      = azurerm_network_interface.myvm1nic1.id
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}

resource "azurerm_linux_virtual_machine" "Ubuntu1" {
  name                  = "myvm1"  
  location              = "Central India"
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.myvm1nic.id]
  size                  = "Standard_B1s"
  admin_username        = "adminuser1"
  admin_password                  = "Adminuser@1!"
  disable_password_authentication = false


  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
} 

resource "azurerm_linux_virtual_machine" "ubuntu2" {
  name                  = "myvm2"  
  location              = "Central India"
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.myvm1nic1.id]
  size                  = "Standard_B1s"
  admin_username        = "adminuser2"
  admin_password                  = "Adminuser@2!"
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
