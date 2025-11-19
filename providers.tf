terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.26.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.12.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.7"
    }
  }
}