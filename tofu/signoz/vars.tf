variable "endpoint" {
  description = "SigNoz endpoint"
  type        = string
  default     = "http://localhost:8080"
}

variable "api_key" {
  description = "SigNoz API Key from Settings -> API Keys"
  type        = string
  default     = null
}

variable "dashboard_urls" {
  description = "List of URLs for SigNoz dashboards"
  type        = list(string)
  default = [
    "https://raw.githubusercontent.com/SigNoz/dashboards/main/clickhouse/clickhouse-overview.json",
    "https://raw.githubusercontent.com/SigNoz/dashboards/main/postgresql/postgresql.json",

    # modifed and mvoed to ./dashboards/*
    # "https://raw.githubusercontent.com/SigNoz/dashboards/main/redis/redis-overview.json",

    # "https://raw.githubusercontent.com/SigNoz/dashboards/refs/heads/main/k8s-infra-metrics/host-metrics.json",
    # "https://raw.githubusercontent.com/SigNoz/dashboards/refs/heads/main/k8s-infra-metrics/k8s-events-receiver.json",
    # "https://raw.githubusercontent.com/SigNoz/dashboards/refs/heads/main/k8s-infra-metrics/kubernetes-cluster-metrics.json",
    # "https://raw.githubusercontent.com/SigNoz/dashboards/refs/heads/main/k8s-infra-metrics/kubernetes-node-metrics-detailed.json",
    # "https://raw.githubusercontent.com/SigNoz/dashboards/refs/heads/main/k8s-infra-metrics/kubernetes-node-metrics-overall.json",
    # "https://raw.githubusercontent.com/SigNoz/dashboards/refs/heads/main/k8s-infra-metrics/kubernetes-pod-metrics-detailed.json",
    # "https://raw.githubusercontent.com/SigNoz/dashboards/refs/heads/main/k8s-infra-metrics/kubernetes-pod-metrics-overall.json",
    # "https://raw.githubusercontent.com/SigNoz/dashboards/refs/heads/main/k8s-infra-metrics/kubernetes-pvc-metrics.json",
  ]
}
