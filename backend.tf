# S3 Bucket for s3 Backend 
resource "aws_s3_bucket" "backend" {
  bucket = "terraform-s3-backend-folder"
  tags = {
    Name        = "terraform-s3-backend-folder"
    Environment = "Development"
  }
}


resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

# backend Provider
terraform {
  backend "s3" {
    bucket = "terraform-s3-backend-folder"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }

}