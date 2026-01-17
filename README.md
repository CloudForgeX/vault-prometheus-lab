Vault + Prometheus Lab (Infrastructure as Code)

Overview
This project demonstrates how to deploy HashiCorp Vault on an AWS EC2 Ubuntu instance using Terraform (Infrastructure as Code), with Prometheus configured for telemetry and monitoring.

It is intended as a lab / learning environment to practice IaC, system automation, and observability setup.

•	Vault runs as a systemd service and stores secrets in /opt/vault/data.
•	Prometheus runs as a systemd service, scraping Vault metrics for observability.
•	Terraform provisions the EC2 instance, configures users, directories, and systemd services automatically.

Features
•	Fully automated deployment using Terraform
•	Vault installation via user_data script
•	Prometheus installation and configuration via files (prometheus.yml and prometheus.service)
•	Proper permissions and directory setup for both Vault and Prometheus
•	Systemd services ensure Vault and Prometheus start automatically on boot
•	Telemetry enabled for Vault and monitored by Prometheus

Prerequisites
•	AWS account (Free Tier eligible: t3.micro instance recommended)
•	Terraform installed locally
•	SSH key pair for EC2 access
•	Security group allowing:
o	TCP 8200 (Vault UI/API)
o	TCP 9090 (Prometheus UI)
