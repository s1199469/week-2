#
#  See https://www.terraform.io/intro/getting-started/variables.html for more details.
#

#  Change these defaults to fit your needs!

variable "esxi_hostname" {
  default = "192.168.1.11"
}

variable "esxi_hostport" {
  default = "22"
}

variable "esxi_hostssl" {
  default = "443"
}

variable "esxi_username" {
  default = "root"
}

variable "esxi_password" {
  default = "Welkom01!"
}

variable "virtual_network" {
  default = "VM Network"
}

variable "disk_store" {
  default = "IACDatastore"
}

variable "vm_hostname" {
  default = "vmtest2704"
}