# Configuración del proveedor de AWS
provider "aws" {
  region = "us-east-2" 
  profile = "default"  
}

# Estado local de Terraform
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}