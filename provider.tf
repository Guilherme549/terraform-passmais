terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.12.0"
    }
  }

  backend "s3" {
    bucket = "falana-variaveis-teste1"
    key = "terraform-state/passmais/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}