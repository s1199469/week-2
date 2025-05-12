# WEEK 2 - OPDRACHT 3
## opdracht voor video
gevraagd wordt om een SSH verbinding op te zetten van een <ins>VM uit opdracht 2A (op ESX gehoste VM)</ins> naar de <ins>Azure hosted VM</ins>.
De private key kan vanaf het beheerstation naar de remote server worden gekopieerd met de <ins>private key van de admin user</ins>. Gebruik hiervoor het scp commando:
**student@devhost:~$ scp /home/student/.ssh/IACLab2key.pem adminuser@192.168.1.50 (=voorbeeldadres):/home/adminuser/.ssh/**
* maak een SSH verbinding met de server met ssh -i ~/.ssh/id-ed25519 adminuser@192.168.1.50
* maak vervolgens vanuit de remote host een ssh-verbinding met de Azure hosted remote server:
**ssh -i ~/.ssh/IACLab2key.pem adminuser@_<public_ip adres van remote server>_**
## toevoegen ontwerptekening
* 12-05-2025: Excelidraw file toegevoegd