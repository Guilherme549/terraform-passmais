resource "aws_route_table" "passmais_public_route_table" {
  vpc_id = aws_vpc.passmais_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.passmais_igw.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-public-rtb"
    }
  )

}
