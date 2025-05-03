Week 2 - LAB 2B
# Azure VM deployment
* VM's krijgen standaard geen public IP meer. Daarom heb ik een resource daarvoor toegevoegd.
Bij de output wordt het ip adres niet getoond, hier zit een vertraging in. Nog een keer runnen zorgt ervoor dat het ip-adres wel wordt getoond. Hiervoor is een fix die in het manifest is verwerkt
# Status
* De VM wordt geinstalleerd en is voorzien van de public key die is aangemaakt in de Azure portal. De private key is gedownload en op de beheer-vm (devhost) geplaatst.
* De VM is met SSH te benaderen met de admin user + private key
* Ip adressen redirecten naar een file kan alleen vanaf de command line. in het manifest is daar geen mogelijkheid voor
* user "iac" wordt aangemaakt met de tekstfile in de home-directory
