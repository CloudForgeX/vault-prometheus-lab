ui            = true
cluster_addr  = "http://127.0.0.1:8201"
api_addr      = "http://127.0.0.1:8200"
disable_mlock = true

storage "raft" {
  path = "/opt/vault/data"
  node_id = "node1"
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable = true
}

telemetry {
  disable_hostname = true

  # Prometheus metrics endpoint
  prometheus_retention_time = "24h"
  prometheus_listen_address = "0.0.0.0:9090"
}