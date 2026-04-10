terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.4.0"
    }
    signoz = {
      source  = "signoz/signoz"
      version = "0.0.11"
    }
  }
}

data "sops_file" "secrets" {
  source_file = "${path.module}/secrets.yaml"
}

provider "signoz" {
  endpoint     = var.endpoint
  access_token = var.api_key != null ? var.api_key : data.sops_file.secrets.data["signoz_api_key"]
}
