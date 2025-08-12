terraform {
  backend "s3" {
    bucket         = "my-reddit-bucket-2025"
    region         = "us-east-1"
    key            = "EKS-DevSecOps-Project/Monitoring-TF/terraform.tfstate"
    #dynamodb_table = "Lock-Files"
    use_lockfile   = false
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}
