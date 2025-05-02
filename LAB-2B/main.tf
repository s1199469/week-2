# Details voor de Azure RM provider

terraform {
  required_providers {
      azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.27.0"      
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  tenant_id = "e36377b7-70c4-4493-a338-095918d327e9"
  subscription_id = "c064671c-8f74-4fec-b088-b53c568245eb"
  features {}
  }

# variables
variable "prefix" {
  default = "s1199469"
}
variable "resourcegroupname" {
default = "S1199469"  
}
variable "location" {
  default = "west europe"  
}

# resource deployment
# resource group aanmaken is weggelaten om te voorkomen dat de huidige RG per ongeluk wordt verwijderd
# bij een terraform destroy

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${var.resourcegroupname}"
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = "${var.resourcegroupname}"
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "pip" {
  name                = "${var.prefix}-pip"
  resource_group_name = "${var.resourcegroupname}"
  location            = "${var.location}"
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  resource_group_name = "${var.resourcegroupname}"
  location            = "${var.location}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "${var.prefix}-vm"
  resource_group_name = "${var.resourcegroupname}"
  location            = "${var.location}"
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_ed25519.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    # https://documentation.ubuntu.com/azure/azure-how-to/instances/find-ubuntu-images/
    sku       = "server-gen1"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}
# even wachten omdat het public IP anders nog niet kan worden getoond
resource "time_sleep" "wait_15_seconds" {
  create_duration = "15s"
}
output "publicip" {
  value = azurerm_public_ip.pip.ip_address
  depends_on = [time_sleep.wait_15_seconds]
}