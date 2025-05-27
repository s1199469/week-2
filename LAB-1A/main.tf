# Basis manifest voor het uitrollen van een VMware ESXi gehoste Ubuntu VM
# Gebruikt de ESXi provider omdat wij voor het lab geen vSphere gebruiken.check "name" {
# https://registry.terraform.io/providers/josenk/esxi/latest

provider "esxi" {
  esxi_hostname      = var.esxi_hostname
  esxi_hostport      = var.esxi_hostport
  esxi_hostssl       = var.esxi_hostssl
  esxi_username      = var.esxi_username
  esxi_password      = var.esxi_password
}


# VM 1
resource "esxi_guest" "Default" {
  guest_name         = var.vm1_hostname
  disk_store         = var.disk_store
  memsize            = var.vm_memsize
  numvcpus           = var.vm_numvcpus
  
ovf_source = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.ova"

  network_interfaces {
    virtual_network = var.virtual_network
  }
    
  guestinfo = {
    "userdata.encoding" = "gzip+base64"
    "userdata"          = base64gzip(data.template_file.Default.rendered)
  }
}
