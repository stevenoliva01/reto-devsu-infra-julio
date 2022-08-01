resource "azurerm_resource_group" "azrg_devsu" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "azvnet_devsu" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address
  location            = azurerm_resource_group.azrg_devsu.location
  resource_group_name = azurerm_resource_group.azrg_devsu.name
  tags                = var.tags
}

resource "azurerm_subnet" "azsubnet_devsu" {
  name                 = var.sub_network_name
  resource_group_name  = azurerm_resource_group.azrg_devsu.name
  virtual_network_name = azurerm_virtual_network.azvnet_devsu.name
  address_prefixes     = var.sub_network_address
}

resource "azurerm_public_ip" "azip_devsu" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.azrg_devsu.location
  resource_group_name = azurerm_resource_group.azrg_devsu.name
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "aznsg_devsu" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.azrg_devsu.location
  resource_group_name = azurerm_resource_group.azrg_devsu.name

  security_rule {
    name                       = "SSH"
    priority                   = 320
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "aznic_devsu" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.azrg_devsu.location
  resource_group_name = azurerm_resource_group.azrg_devsu.name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.azsubnet_devsu.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.azip_devsu.id
  }
}

resource "azurerm_network_interface_security_group_association" "aznisg_devsu" {
  network_interface_id      = azurerm_network_interface.aznic_devsu.id
  network_security_group_id = azurerm_network_security_group.aznsg_devsu.id
}

resource "tls_private_key" "aztls_devsu" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "azvm_devsu" {
  name                = var.virtual_machine_name
  resource_group_name = azurerm_resource_group.azrg_devsu.name
  location            = azurerm_resource_group.azrg_devsu.location
  tags                = var.tags
  size                = var.virtual_machine_size
  admin_username      = var.virtual_machine_admin
  network_interface_ids = [
    azurerm_network_interface.aznic_devsu.id,
  ]

  admin_ssh_key {
    username   = var.virtual_machine_admin
    public_key = tls_private_key.aztls_devsu.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    offer     = "0001-com-ubuntu-server-focal"
    publisher = "Canonical"
    sku       = "20_04-lts-gen2"
  }
}

resource "azurerm_kubernetes_cluster" "azk8s_devsu" {
    name                = var.cluster_aks_name
    location            = var.aks_location
    resource_group_name = azurerm_resource_group.azrg_devsu.name
    dns_prefix          = var.cluster_aks_prefix

    default_node_pool {
        name            = "agentpool"
        node_count      = var.cluster_aks_node_count
        vm_size         = "Standard D2s v3"
        enable_auto_scaling = false
        zones  = []
    }
    
    identity {
        type = "SystemAssigned"
    }
    tags = var.tags
}

resource "azurerm_api_management" "azapim_devsu" {
  name                = var.api_management_name
  location            = azurerm_resource_group.azrg_devsu.location
  resource_group_name = azurerm_resource_group.azrg_devsu.name
  publisher_name      = var.api_management_publisher_name
  publisher_email     = var.api_management_publisher_email

}