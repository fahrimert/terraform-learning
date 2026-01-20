output "nic_id" {
  value = azurerm_network_interface.main.id
  description = "VM modülüne gönderilecek olan Ağ Kartı ID'si"
}

output "public_ip" {
  value = azurerm_public_ip.main.ip_address
  description = "Sunucunun dış IP adresi"
}