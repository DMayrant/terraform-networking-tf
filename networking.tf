resource "aws_eip" "NAT" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.IGW]
}

resource "aws_nat_gateway" "ipv4_NAT" {
  allocation_id = aws_eip.NAT.id
  subnet_id     = aws_subnet.public_subnet.id
  depends_on    = [aws_internet_gateway.IGW]

  tags = merge(local.common_tags, {
    name = "NAT_terraform"
  })
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc_network.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ipv4_NAT.id
  }
}
resource "aws_route_table_association" "private_subnet" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet.id

}
