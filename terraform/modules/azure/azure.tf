# Import Resource Group
resource "azurerm_resource_group" "rg" {
  name      = var.resource_group_name
  location  = var.resource_group_location
}

# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "Vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "Subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}


# Create network interface
resource "azurerm_network_interface" "nic" {
  count               = var.instances
  name                = "NIC${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "NicConfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  count                 = var.instances
  name                  = "EX42-${count.index}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  size                  = "Standard_DS1_v2"

  admin_ssh_key {
    username   = "admin"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

     computer_name                   = "VM-${count.index}"
     admin_username                  = "admin"
     admin_password                  = "wqe2sdf3"
     disable_password_authentication = false
}