#https://jessicagreben.medium.com/how-to-terraform-locking-state-in-s3-2dc9a5665cb6

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = ">= 3.58.0"
  }
  #   backend "s3" {
  #     bucket = "bucket-name"
  #     key    = "some-path/state.tfstate"
  #     region = "eu-west-2"
  #   }
}

provider "aws" {
  region = var.region
}

# resource "aws_s3_bucket" "terraform-state-storage-s3" {
#   bucket = "terraform-remote-state-storage-s3"

#   versioning {
#     enabled = true
#   }

#   lifecycle {
#     prevent_destroy = true
#   }

#   tags = {
#     Name = "S3 Remote Terraform State Store"
#   }
# }

resource "aws_dynamodb_table" "terraform-state-lock" {
  name           = "terraform-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-state-lock"
  }
}