resource "aws_security_group" "vault_sg" {
  name        = "vault_sg"
  description = "Allow necessary ports for Hashicorp Vault"
  vpc_id      = aws_vpc.vault_vpc.id

  tags = {
    Name = "vault_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.vault_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.vault_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.vault_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "vault_8200" {
  security_group_id = aws_security_group.vault_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8200
  ip_protocol       = "tcp"
  to_port           = 8200
}

resource "aws_vpc_security_group_ingress_rule" "vault_8201" {
  security_group_id = aws_security_group.vault_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8201
  ip_protocol       = "tcp"
  to_port           = 8201
}

resource "aws_vpc_security_group_ingress_rule" "prometheus_9090" {
  security_group_id = aws_security_group.vault_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 9090
  ip_protocol       = "tcp"
  to_port           = 9090
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.vault_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
