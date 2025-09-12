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
