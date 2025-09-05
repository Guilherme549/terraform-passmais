resource "aws_subnet" "passmais_subnet_public_1a" {
  vpc_id                  = aws_vpc.passmais_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = merge(
    var.tags,
    {
      Name                     = "${var.project_name}-pub-subnet-1a",
      "kubernetes.io/role/elb" = 1
    }
  )
}


resource "aws_subnet" "passmais_subnet_public_1b" {
  vpc_id                  = aws_vpc.passmais_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = merge(
    var.tags,
    {
      Name                     = "${var.project_name}-pub-subnet-1b",
      "kubernetes.io/role/elb" = 1
    }
  )
}

resource "aws_route_table_association" "passmais_rtb_assoc_1a" {
  subnet_id      = aws_subnet.passmais_subnet_public_1a.id
  route_table_id = aws_route_table.passmais_public_route_table.id
}

resource "aws_route_table_association" "passmais_rtb_assoc_1b" {
  subnet_id      = aws_subnet.passmais_subnet_public_1b.id
  route_table_id = aws_route_table.passmais_public_route_table.id
}

