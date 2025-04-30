# Details voor de provider
provider "esxi" {
  esxi_hostname      = var.esxi_hostname
  esxi_hostport      = var.esxi_hostport
  esxi_hostssl       = var.esxi_hostssl
  esxi_username      = var.esxi_username
  esxi_password      = var.esxi_password
}

resource "esxi_guest" "VM" {
  guest_name         = var.vm_hostname
  disk_store         = var.disk_store

  network_interfaces {
  virtual_network = var.virtual_network
  }
  ovf_source = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.ova"
guestinfo = {
"metadata"          = filebase64("metadata.yaml")
"metadata.encoding" = "base64"
"userdata"          = filebase64("userdata.yaml")
"userdata.encoding" = "base64"
}

}
#
#  Outputs are a great way to output information about your apply.
#

output "ip" {
  value = esxi_guest.VM.ip_address
}