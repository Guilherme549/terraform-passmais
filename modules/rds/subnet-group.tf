resource "aws_db_subnet_group" "rds_subnet_group" {
  for_each = { for key, val in var.banco_de_dados : key => val }

  name       = "rds-subnet-group-prod-${each.value.nome}"
  subnet_ids = var.db_subnet_ids

  tags = merge(
    var.tags,
    {
      Name = "rds-subnet-group-${each.value.nome}"
    }
  )
}
