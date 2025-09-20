variable "passmais_subnet_public_1a" {
  type        = string
  description = "Subnet for passmais Host Lab"
}

variable "passmais_subnet_public_1b" {
  type        = string
  description = "Subnet for passmais Host staging"
}

variable "passmais_sg_id" {
  type        = string
  description = "ID do Security Group"

}

variable "ECR_URI_IMAGE" {
  description = "URI da imagem do ECR"
  type        = string
}

variable "ARN_S3_env" {
  description = "URL do arquivo '.env' que está no bucket S3"
  type        = string

}

variable "ARN_S3_env_backend" {
  description = "URL do arquivo '.env' do backend que está no bucket S3"
  type        = string

}

variable "rds_sg_id" {
  type        = string
  description = "ID do Security Group do RDS"

}

variable "load_balancer_arn" {
  type        = string
  description = "ARN do Load Balancer"
}


variable "passmais_target_group_arn" {
  type        = string
  description = "ARN do Target Group"

}

variable "passmais_target_group_backend_arn" {
  type        = string
  description = "ARN do Target Group"

}



variable "aws_lb_listener_https" {
  type        = string
  description = "ARN do Listener HTTPS do ALB"
  
}

variable "aws_lb_listener_http" {
  type        = string
  description = "ARN do Listener HTTP do ALB"
  
}