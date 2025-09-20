resource "aws_db_instance" "rds" {
  for_each = { for key, val in var.banco_de_dados : key => val }

  allocated_storage    = 200
  storage_type         = "gp2"
  storage_encrypted    = true
  engine               = "postgres"
  engine_version       = "16.8"
  identifier           = each.value.nome
  instance_class       = each.value.instance_type
  db_name              = each.value.nome
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.postgres16"

  iam_database_authentication_enabled = false

  snapshot_identifier = data.aws_db_snapshot.latest.id

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group[each.key].name

  # Cria snapshot
  skip_final_snapshot       = false
  final_snapshot_identifier = "snapshot-passmais-${formatdate("YYYYMMDD-hhmmss", timestamp())}"

  publicly_accessible = true

  # Enquanto possuir esta propiedade o RDS não será destruído
  lifecycle {
    
    ignore_changes  = [ db_name, username]
  }

  tags = merge(
    var.tags,
    {
      Name = "rds-${each.value.nome}"
    }
  )
}
