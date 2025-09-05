resource "aws_ecs_cluster" "passmais_cluster" {
  name = "passmais-terraform"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  
}



