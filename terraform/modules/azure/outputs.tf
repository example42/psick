output "instance_name" {
  value = azurerm_linux_virtual_machine.vm.*.name
}