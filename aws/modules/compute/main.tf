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
  count = terraform.workspace == "prod" ? 2 : 1

  ami           = var.ami_id       
  instance_type = terraform.workspace == "prod" ? "t3.medium" : "t2.micro"

  subnet_id = element(var.public_subnet_ids, count.index)
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data_replace_on_change = true

  user_data = <<-EOF
              #!/bin/bash
              echo "Merhaba! Ben Sunucu Numara: ${count.index + 1}" > index.html
              python3 -m http.server 80 &
              EOF

  tags = {
    Name = "Web-Server-${terraform.workspace}-${count.index + 1}"
  }
}