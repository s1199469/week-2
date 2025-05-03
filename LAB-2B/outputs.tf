output "pubkey_vm1" {
  value=azurerm_linux_virtual_machine.main.admin_ssh_key
}
output "pubkey_vm2" {
  value=azurerm_linux_virtual_machine.main2.admin_ssh_key
}