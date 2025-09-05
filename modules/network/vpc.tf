resource "aws_vpc" "passmais_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true # Ativa a resolução de nomes de domínio (necessário para acessar a internet e serviços AWS por DNS).
  enable_dns_hostnames = true # Permite que instâncias dentro da VPC recebam um nome de host DNS público.
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-vpc"
    }
  )
}
