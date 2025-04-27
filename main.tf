# Details voor de provider
provider "esxi" {
  esxi_hostname      = "192.168.1.11"
  esxi_hostport      = "22"
  esxi_hostssl       = "443"
  esxi_username      = "root"
  esxi_password      = "Welkom01!"
}

resource "esxi_guest" "vmtest2704" {
  guest_name         = "vmtest2704"
  disk_store         = "IACDatastore"

  network_interfaces {
  virtual_network = "VM Network"
  }
  ovf_source = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.ova"
}
#
#  Outputs are a great way to output information about your apply.
#

output "ip" {
  value = esxi_guest.vmtest.ip_address
}