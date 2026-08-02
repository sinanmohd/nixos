terraform {
  backend "s3" {
    bucket = "opentofu"
    key    = "signoz.tfstate"
    endpoints = {
      s3 = "https://s3.bud.studio"
    }
    # Region validation will be skipped
    region = "us-east-1"
    # Skip AWS related checks and validations
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    # Enable path-style S3 URLs (https://<HOST>/<BUCKET> https://developer.hashicorp.com/terraform/language/settings/backends/s3#use_path_style
    use_path_style = true
  }

  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.4.1"
    }
    signoz = {
      source  = "signoz/signoz"
      version = "0.1.1"
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
