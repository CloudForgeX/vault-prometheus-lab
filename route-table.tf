resource "aws_route_table" "vault_route_table" {
  vpc_id = aws_vpc.vault_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vault_igw.id
  }

  tags = {
    Name = "vault_route_table"
  }
}

resource "aws_route_table_association" "vault_route-vault_subnet_1" {
  subnet_id      = aws_subnet.vault_subnet_1.id
  route_table_id = aws_route_table.vault_route_table.id
}
