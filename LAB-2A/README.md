# WEEK 2 - OPDRACHT 1A + OPDRACHT 1B

------
## Opdracht 2A 
maak 3 Ubuntu Virtuele Machines in ESXi:

- 2x met de naam "webserver", 1x met de naam "databaseserver"
- met een automatische gegenereerde Ansible inventory
- met gebruik van cloud-init voor configuratie met shell commando's
- met wget en ntptime, geïnstalleerd met cloud-init
- met een admin gebruiker, toegevoegd met cloud-init
- met ssh public key, toegevoegd met cloud-init

Dit alles moet zoveel mogelijk gebruik van viariabelen

-----
## issues
- count = 2 maakt twee VM's aan in <ins>ESXi</ins>. Omdat deze dezelfde naam hebben kan er maar eentje worden gestart. Als de eerste is uitgezet en de tweede start dan krijgt die geen IP adres van DHCP. 
- IP adres verkrijgen van pfsense lijkt soms niet te werken. In pfsense de DHCP service omzetten vabn ISC naar KEA heeft dit opgelost. 
-----
## status
- de in het lab gevraagde VM's worden aangemaakt. Ze zijn toegankelijk met SSH met een met cloud-init aangemaakte admin user + public key. wget en ntptime zijn te openen.
---- 
## wegschrijven IP adressen in ansible inventory file
methode: uitvoer in een array met variabelen die de waarde van de ip adressen bevatten. Met de terraform __local_file__ resource kan een tekstfile worden aangemaakt, in dit geval inventory.ini 

> locals {
>
>  ips = [esxi_guest.Default[0].ip_address,esxi_guest.Default[1].ip_address,esxi_guest.Default2[0].ip_address]
>
> }
>
>resource "local_file" "ipaddresses" { 
   
>   content = <<-EOT <br>
   
>   [webservers]
   
>   %{ for ip in local.ips }${ip}
   
>   %{ endfor }
  
 >  [databaseservers]
   
 >  EOT
>
>filename = "${path.module}/inventory.ini"

----

# Opdracht 2B
Maak 1 Ubuntu Virtuele Machine aan in Azure

- De VM is van het type “Standard_B2ats_v2”
- Je eerder geuploade SSH key wordt gebruikt.
- Je VM heeft een publiek IP adres
- Je maakt de user ‘iac’ aan.
- Via CloudInit wordt er een bestand ‘hello.txt’ in /home/iac geplaatst met de inhoud ‘Hello World’
- Het ip adres van elke machine komt in een bestand op je beheer systeem.
- Het moet dus 1 manifest zijn waarin 2 dezelfde VM’s aangemaakt worden.
- Maak in je Terraform manifest gebruik van variabelen waar dit kan. Zet deze variabelen in een apart bestand.

-----
## issues 