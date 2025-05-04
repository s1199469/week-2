# WEEK 2 - LAB 2B
## Azure VM deployment
* VM's krijgen standaard <ins>geen public IP</ins> meer. Daarom heb ik een resource moeten toevoegen. Deze is terug te vinden in de azurerm provider documentatie. 


## issues
* Als een key-paar wordt aangemaakt in de Azure portal moet de private key meteen worden gedownload en veiliggesteld. Deze is daarna niet meer te downloaden (zonder opnieuw te genereren). De public key wordt volledig getoond en kan als plain-tekst worden gekopieerd. Ik vind zelf het gebruiken van een public key file die al op het beheerstation staat veiliger omdat deze alleen toegankelijk is voor het lokale beheeraccount.
* Terraform acties zijn alleen mogelijk als er vooraf is ingelogd op Azure. Managed identities kunnen niet worden aangemaakt omdat een student-account daar geen rechten voor heeft op de tenant. Installeer Azure CLI en log in met **az login -use-decive-code**. Open in een webbrowser https://aka.ms/devicelogin en vul de code in. Selecteer het account. 
* Bij de output wordt het ip adres niet getoond, hier zit een vertraging in omdat het public IP adres pas wordt toegewezen als de VM opgestart is. Nog een keer apply uitvoeren zorgt ervoor dat het ip-adres wel wordt getoond maar is omslachtig. Er is een fix die in het manifest is verwerkt. Zie:  https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip.html

Een voorbeeld van de fix is:

data "azurerm_public_ip" "pip" {
      name                = azurerm_public_ip.pip.name
        resource_group_name = azurerm_linux_virtual_machine.main.resource_group_name
}

output "public_ip_addressVM1" {
      value = data.azurerm_public_ip.pip.ip_address
    }

## Status
* De VM wordt geinstalleerd en is voorzien van de public key die is aangemaakt in de Azure portal. De private key is gedownload en op de beheer-vm (devhost) geplaatst.
* De VM is met SSH te benaderen met de admin user + private key
* Ip adressen redirecten naar een file kan alleen vanaf de command line. in het manifest is daar geen mogelijkheid voor
* user "iac" wordt aangemaakt met de tekstfile in de home-directory
