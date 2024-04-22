# S3 Bucket
resource "aws_s3_bucket" "example-0001" {
  bucket = "220424-1-tfbucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}