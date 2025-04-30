# week-2
Labfiles week 2
# 30-4-2025
Veel problemen met cloud-init en verbinden met SSH
oorzaak nog niet helemaal bekend. Werkende clou-init file heet userdata.tpl
in main was de objectnaam "Default" niet consequent gebruikt

# variabelen
de variabelen zijn gedefinieerd in de file: variables.tf Dit hoeft maar éénmalig voor alle gebruikte variabelen
de waarden kunnen worden opgegeven in een .tfvars file. De default waarden in variables.tf worden overruled
in terraform plan|apply|destroy kan de parameter -var-file="<file>.tfvars" worden meegegeven. je kan ook tfvars automatisch laten inlezen door de extensie auto.tfvars te gebruiken.
voorbeelden van variabelen gebruik:
in variables.tf:

variable "vm_hostname" {
  default = "vmtest3004"
}
variable "vm_userconfigfile" {
  type =string
}

In de tfvars file staan de waarden als volgt:
vm_hostname = "demovm3004"
vm_userconfigfile = "userdata.tpl"