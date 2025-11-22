# Referência à zona existente no Route 53
data "aws_route53_zone" "selected" {
  zone_id = "Z09879133JX6OT5LLTDJT"
}

# Recurso para criação do certificado ACM
resource "aws_acm_certificate" "cert" {
  domain_name       = var.record_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "PRD passmais SSL Certificate"
  }
}

resource "aws_acm_certificate" "cert_backend" {
  domain_name       = var.record_name_backend
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "PRD passmais api SSL Certificate"
  }
}


resource "aws_route53_record" "cert_validation_backend" {
  for_each = {
    for dvo in aws_acm_certificate.cert_backend.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = data.aws_route53_zone.selected.zone_id
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 300
  type            = each.value.type
}




# Recurso para criação do registro DNS de validação do certificado
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = data.aws_route53_zone.selected.zone_id
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 300
  type            = each.value.type
}

# Recurso para validação do certificado ACM
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}


resource "aws_acm_certificate_validation" "cert_validation_backend" {
  certificate_arn         = aws_acm_certificate.cert_backend.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation_backend : record.fqdn]
}

# Registro DNS para apontar o domínio do ambiente PRD para o Load Balancer
resource "aws_route53_record" "site_prd" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.record_name
  type    = "CNAME"
  ttl     = 300
  records = [var.load_balancer_dns_name]

  depends_on = [aws_acm_certificate_validation.cert_validation]
}


resource "aws_route53_record" "site_prd_backend" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.record_name_backend
  type    = "CNAME"
  ttl     = 300
  records = [var.load_balancer_dns_name]

  depends_on = [aws_acm_certificate_validation.cert_validation_backend]
}
