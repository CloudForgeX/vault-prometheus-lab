resource "aws_vpc" "vault_vpc" {
  cidr_block           = local.cidr_block.vpc
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vault_vpc"
  }
}

resource "aws_internet_gateway" "vault_igw" {
  vpc_id = aws_vpc.vault_vpc.id

  tags = {
    Name = "vault_igw"
  }
}
