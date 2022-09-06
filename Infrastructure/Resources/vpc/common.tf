terraform {
    required_version = ">= 0.11.11"
    backend "s3" {
        bucket = "serv-backend-bucket"
        key    = "vpc/terraform.tfstate"
        region = "us-east-1"
    }
}

provider "aws" {
    region     = var.aws_region
}
