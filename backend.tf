terraform {
    backend "s3" {
        bucket = "kubectl-bucket-prac"
        key = "env/dev/terraform.tfstate"
        region = "eu-west-2"
    }
}