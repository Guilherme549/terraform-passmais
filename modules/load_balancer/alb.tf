resource "aws_lb" "passmais_loadbalancer" {
  name               = "passmais"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.db_subnet_ids

  enable_deletion_protection = false


  tags = merge(
    var.tags,
    { "Name" : "${var.project_name}-alb" }
  )
}

resource "aws_lb_listener" "passmais_https_listener_backend" {
  load_balancer_arn = aws_lb.passmais_loadbalancer.arn
  port              = "444"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
  certificate_arn   = var.cert_validation_arn_backend

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_backend_arn
  }
}


resource "aws_lb_listener" "passmais_https_listener" {
  load_balancer_arn = aws_lb.passmais_loadbalancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
  certificate_arn   = var.cert_validation_arn

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}


resource "aws_lb_listener" "passmais_http_listener" {
  load_balancer_arn = aws_lb.passmais_loadbalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      host        = var.record_name
      path        = "/#{path}"
      query       = "#{query}"
    }
  }
}


resource "aws_lb_listener_rule" "redirect_host_header" {
  listener_arn = aws_lb_listener.passmais_https_listener.arn
  priority     = 10

  action {
    type = "redirect"

    redirect {
      host        = var.record_name
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      path        = "/#{path}"
      query       = "#{query}"
    }
  }

  condition {
    host_header {
      values = [aws_lb.passmais_loadbalancer.dns_name]
    }
  }
}


resource "aws_lb_listener_rule" "redirect_host_header_backend" {
  listener_arn = aws_lb_listener.passmais_https_listener_backend.arn
  priority     = 10

  action {
    type = "redirect"

    redirect {
      host        = var.record_name_backend
      port        = "444"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      path        = "/#{path}"
      query       = "#{query}"
    }
  }

  condition {
    host_header {
      values = [aws_lb.passmais_loadbalancer.dns_name]
    }
  }
}


resource "aws_lb_listener_rule" "redirect_host_header_for_correct_url" {
  listener_arn = aws_lb_listener.passmais_https_listener.arn
  priority     = 9

  action {
    type = "redirect"

    redirect {
      host        = var.record_name
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      path        = "/#{path}"
      query       = "#{query}"
    }
  }

  condition {
    host_header {
      values = [var.domain_name]
    }
  }
}