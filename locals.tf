locals {
  banco_de_dados = {
    "rds" = {
      instance_type = "db.t3.micro"
      nome          = "passmaisdb"
    }
  }
  tags = {
    Projects = var.project_name
  }
}