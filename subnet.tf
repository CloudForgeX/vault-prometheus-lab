resource "aws_subnet" "vault_subnet_1" {
  vpc_id                  = aws_vpc.vault_vpc.id
  cidr_block              = local.cidr_block.public_subnet_1
  availability_zone       = var.zone
  map_public_ip_on_launch = true

  tags = {
    Name = "vault_subnet_1"
  }
}
