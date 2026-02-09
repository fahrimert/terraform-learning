resource "github_repository" "example" {
  name        = "terraform-ile-olusturuldu"
  description = "Bu repo Terraform tarafindan kod ile olusturuldu!"
  
  visibility  = "public"
  auto_init   = true

  has_issues  = true
  
  topics = ["terraform", "devops", "learning", "infrastructure-as-code"]

}
resource "github_branch_protection" "main" {
  repository_id = github_repository.example.node_id
  pattern       = "main"

  enforce_admins = false

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = 1
  }
}

resource "github_issue_label" "bug" {
  repository  = github_repository.example.name
  name        = "hata-var"
  description = "Kodda bir seyler ters gitti!"
  color       = "d73a4a"
}

resource "github_issue_label" "feature" {
  repository  = github_repository.example.name
  name        = "yeni-ozellik"
  description = "Yeni bir seyler ekliyoruz"
  color       = "a2eeef"
}

resource "github_issue_label" "devops" {
  repository  = github_repository.example.name
  name        = "devops-isi"
  description = "Altyapi ve CI/CD ile ilgili isler"
  color       = "7057ff"
}

resource "github_repository_file" "infra_rules" {
  repository          = github_repository.example.name
  branch              = "main"
  file                = "INFRASTRUCTURE.md"
  content             = <<EOT
# Altyapı Kuralları

Bu repo **Terraform** tarafindan yönetilmektedir.

## Kurallar
1. Main branch'e dogrudan push atmak yasaktir.
2. Pull Request acmadan once testleri calistirin.
3. Altyapi degisiklikleri icin `infra` ekibiyle gorusun.

_Son Guncelleme: ${timestamp()}_
EOT

  commit_message      = "docs: add infrastructure rules via terraform"
  overwrite_on_create = true
}

resource "github_branch" "development" {
  repository = github_repository.example.name
  branch     = "develop"
  
  source_branch = "main"
}

resource "github_repository_collaborator" "partner" {
  repository = github_repository.example.name
  username   = var.collaborator_username
  permission = "push"
}