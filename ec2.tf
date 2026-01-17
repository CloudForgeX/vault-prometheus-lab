resource "aws_instance" "vault_instance" {
  ami                         = "ami-0ecb62995f68bb549"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.vault_subnet_1.id
  associate_public_ip_address = true
  key_name                    = "cloudforgex-key-pair-3"
  vpc_security_group_ids = [
    aws_security_group.vault_sg.id
  ]

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
  }

  connection {
    host        = self.public_ip
    user        = "ubuntu"
    type        = "ssh"
    private_key = file("C:/Users/BOBBY/cloudforgex-crypto-keys/cloudforgex-key-pair-3.pem")
  }

  user_data_replace_on_change = true

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
#!/bin/bash
set -euxo pipefail

# -----------------------------
# Update packages & install dependencies
# -----------------------------
apt-get update
apt-get install -y curl gnupg lsb-release wget tar

# -----------------------------
# Install Vault
# -----------------------------
curl -fsSL https://apt.releases.hashicorp.com/gpg \
  | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
> /etc/apt/sources.list.d/hashicorp.list

apt-get update
apt-get install -y vault

# -----------------------------
# Vault directories
# -----------------------------
sudo mkdir -p /opt/vault/data
sudo chown -R vault:vault /opt/vault/data
sudo chmod 750 /opt/vault/data

sudo mkdir -p /etc/vault.d
sudo chown -R vault:vault /etc/vault.d
sudo chmod 750 /etc/vault.d

# -----------------------------
# Install Prometheus binaries
# -----------------------------
useradd --no-create-home --shell /bin/false prometheus || true
mkdir -p /etc/prometheus /var/lib/prometheus
chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
chmod 750 /etc/prometheus /var/lib/prometheus

PROM_VERSION="3.5.0"
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v$${PROM_VERSION}/prometheus-$${PROM_VERSION}.linux-amd64.tar.gz
tar xvf prometheus-$${PROM_VERSION}.linux-amd64.tar.gz
mv prometheus-$${PROM_VERSION}.linux-amd64/prometheus /usr/local/bin/
mv prometheus-$${PROM_VERSION}.linux-amd64/promtool /usr/local/bin/
chmod +x /usr/local/bin/prometheus /usr/local/bin/promtool
rm -rf prometheus-$${PROM_VERSION}.linux-amd64*
EOF

  provisioner "file" {
    source      = "vault.hcl"
    destination = "/home/ubuntu/vault.hcl"
  }

  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait || true",
      "sudo mv /home/ubuntu/vault.hcl /etc/vault.d/vault.hcl",
      "sudo chown vault:vault /etc/vault.d/vault.hcl",
      "sudo chmod 640 /etc/vault.d/vault.hcl"
    ]
  }

  provisioner "file" {
    source      = "prometheus.yml"
    destination = "/home/ubuntu/prometheus.yml"
  }

  provisioner "file" {
    source      = "prometheus.service"
    destination = "/home/ubuntu/prometheus.service"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /home/ubuntu/prometheus.yml /etc/prometheus/prometheus.yml",
      "sudo mv /home/ubuntu/prometheus.service /etc/systemd/system/prometheus.service",
      "sudo chown -R prometheus:prometheus /etc/prometheus",
      "sudo chmod 640 /etc/prometheus/prometheus.yml",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable vault prometheus",
      "sudo systemctl start vault prometheus"
    ]
  }

  tags = {
    Name        = "vault_instance"
    environment = "staging"
  }
}
