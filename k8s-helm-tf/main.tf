resource "kubernetes_namespace" "lab_ns" {
  metadata {
    name = "terraform-helm-lab"
  }
}

resource "helm_release" "my_web_server" {
  name       = "nginx-release"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "nginx"
  
  namespace  = kubernetes_namespace.lab_ns.metadata[0].name

  set {
    name  = "service.type"
    value = "NodePort"
  }

  set {
    name  = "replicaCount"
    value = "2"
  }
}