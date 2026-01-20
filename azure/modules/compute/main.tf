resource "azurerm_linux_virtual_machine" "main" {
  name                = "my-vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = "adminuser"
  
  network_interface_ids = [
    var.nic_id, 
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOF
              #!/bin/bash
              while fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1; do
                   echo "Waiting for apt lock..."
                   sleep 5
              done

              sudo apt-get update
              sudo apt-get install -y docker.io
              
              sudo systemctl start docker
              sudo systemctl enable docker
              
              sudo usermod -aG docker adminuser
              EOF
  )
}