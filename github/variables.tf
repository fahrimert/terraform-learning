variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}
variable "collaborator_username" {
    description = "Projeye eklenecek kisinin GitHub kullanici adi"
  type        = string
}