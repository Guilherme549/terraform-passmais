variable "bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

variable "s3_vpce_id" {
  description = "ID do VPC Endpoint S3 permitido"
  type        = string
  default     = "vpce-01cafa49a6b106e18"
}
