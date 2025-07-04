terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
  }

  #backend "s3" {
  #  bucket = "mybucket"
  #  key    = "path/to/my/key"
  #  region = "us-west-1"
  #}
}