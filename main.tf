 terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "terraform"
  region  = var.deployment_region
}

resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}

resource "aws_s3_bucket" "terraform_state_s3" {
  bucket = "terraform-remote-state"
  force_destroy = true
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource = "aws_dynamodb_table" "terraform_locks" {
  name = "tf-up-and-run-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
    attribute {
      name = "LockID"
      type = "S"
    }
}