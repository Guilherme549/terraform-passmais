resource "aws_internet_gateway" "passmais_igw" {
  vpc_id = aws_vpc.passmais_vpc.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-igw"
    }
  )
}
