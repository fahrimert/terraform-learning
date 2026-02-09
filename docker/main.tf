resource "null_resource" "nginx_container" {
  
  triggers = {
    name = var.container_name
    port = var.host_port
    index_hash = filemd5("${path.module}/index.html")
  }

  provisioner "local-exec" {
    command = "docker rm -f ${self.triggers.name} || true" 
  }

  provisioner "local-exec" {
    command = "docker run -d --name ${self.triggers.name} -p ${self.triggers.port}:80 -v $(pwd)/index.html:/usr/share/nginx/html/index.html nginx:latest"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "docker rm -f ${self.triggers.name}"
  }
}