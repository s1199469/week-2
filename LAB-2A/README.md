# WEEK 2 - LAB 2B
## Algemene informatie
ESXi deployment gebruikt de volgende files:
- main.tf
- variables.tf
- vm-1.tpl
- vm-1.tfvars
de volgende variabelen zijn toegevoegd:
- vm_memsize
- vm_numvcpus
- count

## issues
- count = 2 maakt twee VM's aan in <ins>ESXi</ins>. Omdat deze dezelfde naam hebben kan er maar eentje worden gestart. Als de eerste is uitgezet en de tweede start dan krijgt die geen IP adres van DHCP. 
- IP adres verkrijgen van pfsense lijkt soms niet te werken. In pfsense de DHCP service omgezet cabn ISC naar KEA. 

## status
- de in het lab gevraagde VM's worden aangemaakt. Ze zijn toegankelijk met SSH met een met cloud-init aangemaakte admin user + public key. wget en ntptime zijn door cloud-init toegevoegd.

## wegschrijven IP adressen in ansible inventory file
methode:

locals {
  ips = [esxi_guest.Default[0].ip_address,esxi_guest.Default[1].ip_address,esxi_guest.Default2[0].ip_address]
}
resource "local_file" "ipaddresses" {
   content = <<-EOT
   [webservers]
   %{ for ip in local.ips }${ip}
   %{ endfor }
   [databaseservers]
   EOT