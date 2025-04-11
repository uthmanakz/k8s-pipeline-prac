terraform {
  backend "s3" {
    bucket         = "k8s-net-bucket"
    key            = "terraform/state.tfstate"
    region         = "eu-west-2"
  }
}