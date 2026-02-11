terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "mcdp-tfstate-058264199274-eu-west-2"
    key            = "aws/dev/network/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "mcdp-tfstate-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-west-2"
}
