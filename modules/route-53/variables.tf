variable "domain_name" {
  description = "Domain name"
  type        = string
}


variable "record_name" {
  description = "Record host"
  type        = string
}

variable "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  type        = string

}
