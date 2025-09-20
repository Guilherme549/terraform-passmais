variable "cidr_block" {
  type        = string
  description = "Networing CIDR block to be used for the VPC"
}

variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"
}

variable "ARN_S3_env" {
  description = "URL do arquivo '.env' que está no bucket S3"
  type        = string

}

variable "ARN_S3_env_backend" {
  description = "URL do arquivo '.env' do backend que está no bucket S3"
  type        = string

}

variable "ECR_URI_IMAGE" {
  description = "URI da imagem do ECR"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "record_name" {
  description = "Record host"
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

variable "db_instance_identifier_for_snapshot" {
  description = "Identificador do snapshot do RDS para restauração"
  type        = string

}

variable "record_name_backend" {
  description = "Record host do backend"
  type        = string

}