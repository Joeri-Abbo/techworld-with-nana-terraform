terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.53.0"
    }
    linode = {
      source  = "linode/linode"
      version = "1.30.0"
    }
  }
}