output "target_group_arn" {
  value = aws_lb_target_group.passmais_target_group.arn
}


output "target_group_backend_arn" {
  value = aws_lb_target_group.passmais_backend_target_group.arn
}
