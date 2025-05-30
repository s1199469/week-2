# WEEK 2 - OPDRACHT 2B
----
## Azure VM deployment
* Azure Virtual Machines krijgen standaard <ins>geen public IP adres</ins> meer. Daarom heb ik een apart __public IP__ resource toegevoegd. Deze is terug te vinden in de azurerm provider documentatie. 

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

----
## issues
* Als een key-paar wordt aangemaakt in de Azure portal moet de private key meteen worden gedownload en veiliggesteld. Deze is daarna niet meer te downloaden (zonder opnieuw te genereren). De public key wordt volledig getoond en kan als plain-tekst worden gekopieerd. Ik vind zelf het gebruiken van een public key file die al op het beheerstation staat veiliger omdat deze alleen toegankelijk is voor het lokale beheeraccount.
* Terraform acties zijn alleen mogelijk als er vooraf is ingelogd op Azure via de CLI (Command Line Interface). Managed identities kunnen niet worden aangemaakt omdat een student-account daar geen rechten voor heeft op de tenant. Omdat studenten in Azure Resource Groups uitrollen en geen identiteiten kunnen beheren, is er een workaround nodig. Deze houdt een handmatige actie in.  Installeer Azure CLI en log in met de optie **az login -use-device-code**. Open in een webbrowser https://aka.ms/devicelogin en vul de code in. Selecteer het student-account en log verder in. De sessie blijft actief tot er wordt uitgelogd met **az disconnect** 
* Bij de output wordt het ip adres niet getoond, hier zit een vertraging in omdat het public IP adres pas wordt toegewezen als de VM opgestart is. Nog een keer apply uitvoeren zorgt ervoor dat het ip-adres wel wordt getoond maar is omslachtig. Er is een fix die in het manifest is verwerkt. Zie:  https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip.html
----
## Status
* De VM wordt geinstalleerd en is voorzien van de public key die is aangemaakt in de Azure portal. De private key is gedownload en handmatig op de beheer-vm (devhost) geplaatst.
* De VM is met SSH te benaderen met de admin user + private key
* Ip adressen redirecten naar een file kan alleen vanaf de command line. in het manifest is daar geen mogelijkheid voor
* user "iac" wordt aangemaakt met de tekstfile in de home-directory
-----
## Fix voor Private IP adres
> data "azurerm_public_ip" "pip" {
>     name = azurerm_public_ip.pip.name
>     resource_group_name = azurerm_linux_virtual_machine.main.resource_group_name
> }
> output "public_ip_addressVM1" {
>      value = data.azurerm_public_ip.pip.ip_address
> }
