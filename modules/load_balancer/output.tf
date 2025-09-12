output "load_balancer_arn" {
  value = aws_lb.passmais_loadbalancer.arn
}

output "load_balancer_dns_name" {
  value = aws_lb.passmais_loadbalancer.dns_name

}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "aws_lb_listener_https" {
  value = aws_lb_listener.passmais_https_listener.arn

}


output "aws_lb_listener_http" {
  value = aws_lb_listener.passmais_http_listener.arn
}