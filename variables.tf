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