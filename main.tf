provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "kubectl_node" {
    ami = "ami-01e479df1702f1d13"
    instance_type = "t2.micro"
    key_name = "uthmanakz"

    tags = {
        Name = "kubectl-node"
    }
}