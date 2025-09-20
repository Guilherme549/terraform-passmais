output "acm_certificate_validated_arn" {
  value = aws_acm_certificate_validation.cert_validation.certificate_arn
}


output "acm_certificate_validated_backend_arn" {
  value = aws_acm_certificate_validation.cert_validation_backend.certificate_arn
}
