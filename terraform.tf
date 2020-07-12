# Configure Terraform.

terraform {
  required_version = "~> 0.12"

  # https://www.terraform.io/docs/backends/types/s3.html
  backend "s3" {
    bucket = "terraform-backend"
    region = "us-east-1"
    key    = "appsync-lambda/terraform.tfstate"
  }
}
