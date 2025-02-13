provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "backend" {
  bucket = "lukas-multicloud-backend-1302"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.backend.id
  versioning_configuration {
    status = "Enabled"
  }
}