# Vault + Prometheus Lab

## Overview

This project deploys **HashiCorp Vault** on an **Ubuntu AWS EC2 instance** using **Terraform**, and configures **Prometheus** for telemetry monitoring.  

It is intended as a **lab environment** to practice Infrastructure as Code (IaC) and observability setup.

---

## Features

- Vault installed via Terraform and `user_data` scripts  
- Prometheus installed and configured to scrape Vault metrics  
- Proper directory setup and permissions for both services  
- Systemd services ensure Vault and Prometheus start automatically  

---

## Usage

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/vault-prometheus-lab.git
cd vault-prometheus-lab/terraform
````

1. **Update Terraform variables**

- Ensure your **SSH key path** in `terraform.tfvars` is correct
- Verify that security group IDs and subnet IDs match your AWS environment

1. **Deploy with Terraform**

```bash
terraform init
terraform plan
terraform apply
```

1. **Access the services**

- Vault UI: `http://<EC2_PUBLIC_IP>:8200`
- Prometheus UI: `http://<EC2_PUBLIC_IP>:9090`

---

## Folder Structure

-```
terraform/
├─ ec2.tf                # EC2 instance setup
├─ security-group.tf
├─ subnet.tf
├─ route-table.tf
├─ provider.tf
├─ variables.tf
├─ output.tf
├─ vault.hcl             # Vault configuration
├─ vault.service         # Vault systemd service
├─ prometheus.yml        # Prometheus configuration
├─ prometheus.service    # Prometheus systemd service
└─ README.md
-```

---

## Notes

- Vault data is stored in `/opt/vault/data`
- Prometheus stores metrics in `/var/lib/prometheus`
- Prometheus configuration is in `/etc/prometheus`

---

## Future Improvements

- Add **Grafana** for dashboards
- Enable **TLS for Vault telemetry**
- Expand to a **multi-node Vault cluster** for HA testing
