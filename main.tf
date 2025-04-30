# Details voor de provider
provider "esxi" {
  esxi_hostname      = var.esxi_hostname
  esxi_hostport      = var.esxi_hostport
  esxi_hostssl       = var.esxi_hostssl
  esxi_username      = var.esxi_username
  esxi_password      = var.esxi_password
}

# Template for initial configuration bash script
#    template_file is a great way to pass variables to
#    cloud-init
data "template_file" "Default" {
  template = file("userdata.tpl")
  vars = {
    HOSTNAME = var.vm_hostname
    HELLO = "Hello world!"
  }
}

resource "esxi_guest" "Default" {
  guest_name         = var.vm_hostname
  disk_store         = var.disk_store

ovf_source = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.ova"

  network_interfaces {
    virtual_network = var.virtual_network
  }
    
  guestinfo = {
    "userdata.encoding" = "gzip+base64"
    "userdata"          = base64gzip(data.template_file.Default.rendered)
  # "userdata"          = "filebase64.cloud-init.yaml"
  # "userdata.encoding" = "base64"
  }
}
#
#  Outputs are a great way to output information about your apply.
#

output "ip" {
  value = esxi_guest.Default.ip_address
}