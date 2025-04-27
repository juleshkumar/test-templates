terraform {
  backend "s3" {
    bucket     = "terrafrom-testing-bucket-uipl"
    key        = "dev/backend/test"
    region     = "us-east-1"
  }
}

