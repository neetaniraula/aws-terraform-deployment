terraform {
  backend "s3" {
    bucket = "neeta-aws-terraform"         
    key    = "neeta/terraform.tfstate"   
    region = "us-east-1"                   
    encrypt = true                         
  }
}
