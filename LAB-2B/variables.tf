# variables
variable "vmreferencename" {
  default = "main"
}
variable "vmname" {
  default = "s1199469-vm01"
}
variable "vmname2" {
  default = "s1199469-vm02"
}
variable "adminuser" {
  default = "adminuser"
}
variable "resourcegroupname" {
default = "S1199469"  
}
variable "location" {
  default = "west europe"  
}
variable "vmsize" {
  default = "Standard_B2ats_v2"
}
variable "customdatafile" {
  default= "userdata-vm01.yaml"
}
variable "customdatafile2" {
  default= "userdata-vm02.yaml"
}
# gebruiken als de key is gegenereerd met ssh-keygen
variable "publickeyfile" {
  default = "(~/.ssh/id_ed25519.pub)"  
# gebruiken bij Azure gegenereerde key. De public key ken niet worden gedownload maar wel als tekst gekopieerd vanuit de portal.
}
variable "adminpublickey" {
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPs0UvMTN//NKvmgjv6Tm22/jzjhORt6JoPrLtlSGcCY generated-by-azure"
}
variable "image_publisher" {
  default = "Canonical"
}
variable "image_offer" {
  default = "ubuntu-24_04-lts"
}
variable "image_sku" {
  default = "server-gen1"
}
variable "image_version" {
  default = "latest"
}
variable "osdisk_storageaccounttype" {
  default = "Standard_LRS"
}
variable "osdisk_caching" {
  default = "ReadWrite"
}

  

  
