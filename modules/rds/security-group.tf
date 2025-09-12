resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group-prd"
  description = "Permitir acesso ao RDS apenas da EC2 de prod"
  vpc_id      = var.vpc

  ingress {
    description     = "Permitir postgres da EC2 de prod"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = []
    security_groups = [var.passmais_sg_id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "rds-sg-prd"
    }
  )
}
