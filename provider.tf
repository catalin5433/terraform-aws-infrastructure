terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.11.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-aws-infrastructure-s3-tfstate"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    use_lockfile = true
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

