terraform {
  backend "s3" {
    bucket         = "terraform-state-grace-pipeline"
    key            = "csv-pipeline/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
