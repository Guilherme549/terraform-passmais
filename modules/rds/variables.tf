variable "vpc" {
  type        = string
  description = "VPC for SG"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resourses"
}

variable "passmais_sg_id" {
  description = "ID do Security Group da EC2"
  type        = string

}


variable "db_password" {
  type        = string
  sensitive   = true
  description = "Senha do banco de dados"
}

variable "db_username" {
  type        = string
  sensitive   = true
  description = "Digite o username do snapshot do banco de dados"
}

variable "db_name" {
  type        = string
  description = "Nome do banco de dados"

}


variable "banco_de_dados" {
  description = "Mapa de criação do banco de dados"
  type = map(object({
    instance_type = string
    nome          = string
  }))
}

variable "db_subnet_ids" {
  description = "Lista de subnets para o RDS"
  type        = list(string)
}

variable "db_instance_identifier_for_snapshot" {
  description = "Identificador do snapshot do RDS para restauração"
  type        = string

}