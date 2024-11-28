terraform {
  required_version = ">= 1.10.0" 

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.12.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.3" 
    }
  }

  backend "gcs" {
    bucket  = "myapp-terraform"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = "mysandbox-443010"
  region  = "asia-northeast1"
}

