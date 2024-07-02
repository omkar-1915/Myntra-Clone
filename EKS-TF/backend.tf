terraform {
  backend "s3" {
    bucket = "newdata1412" # Replace with your actual S3 bucket name
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"
  }
}
