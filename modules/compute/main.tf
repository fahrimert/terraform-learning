resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Security wall for web server"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web Security Group"
  }
}

resource "aws_instance" "web_server" {
  ami           = var.ami_id       
  instance_type = var.instance_type

  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Merhaba Terraform! Bu sunucu kod ile kuruldu , deneme 1 deneme 2 deneme 3." > index.html
              python3 -m http.server 80 &
              EOF

  tags = {
    Name = "Terraform-Learning-Web-Server"
  }
}