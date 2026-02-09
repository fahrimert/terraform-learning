resource "github_repository" "example" {
  name        = "terraform-ile-olusturuldu"
  description = "Bu repo Terraform tarafindan kod ile olusturuldu!"
  
  visibility  = "public"
  auto_init   = true
}