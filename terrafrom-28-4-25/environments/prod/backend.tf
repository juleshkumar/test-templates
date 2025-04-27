terraform {
  backend "s3" {
    bucket     = "terrafrom-testing-bucket-uipl"
    key        = "prod/backend/test"
    region     = "us-east-1"
  }
}

