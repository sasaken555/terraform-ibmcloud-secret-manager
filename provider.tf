terraform {
  required_providers {
    # https://registry.terraform.io/providers/IBM-Cloud/ibm/latest
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.16.1"
    }
  }
}

provider "ibm" {
  # API key is provided from environment variable "IC_API_KEY"
  region = var.region
}
