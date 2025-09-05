resource "aws_ecr_repository" "repositorio_passmais" {
  name                 = "passmais-terraform"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true
}
