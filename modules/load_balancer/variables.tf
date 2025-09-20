variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resourses"
}

variable "vpc" {
  type        = string
  description = "VPC for SG"
}

variable "passmais_sg_id" {
  type        = string
  description = "ID do Security Group"

}


variable "db_subnet_ids" {
  description = "Lista de subnets para o RDS"
  type        = list(string)
}


variable "target_group_arn" {
  description = "ARN do Target Group"
  type        = string

}

variable "cert_validation_arn" {
  description = "ARN do Route53 Record para validação do certificado SSL"
  type        = string

}

variable "record_name" {
  description = "Record host"
  type        = string
}

variable "target_group_backend_arn" {
  description = "ARN do Target Group do backend"
  type        = string
  
}

variable "cert_validation_arn_backend" {
  description = "ARN do certificado SSL do backend"
  type        = string  
  
}

variable "record_name_backend" {
  description = "Record host do backend"
  type        = string
  
}
variable "domain_name" {
  description = "Domain name"
  type        = string
}