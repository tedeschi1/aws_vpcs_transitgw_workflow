terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.14.1"
    }
  }
}

#AWS Provider Configuration
provider "aws" {
    region = "us-east-1"
}

#AWS Provider Configuration
provider "aws" {
  alias = "us-east-2"
  region = "us-east-2"
}
