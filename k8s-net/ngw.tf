resource "aws_eip" "k8s_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "k8s_ngw" {
  allocation_id = aws_eip.k8s_eip.id
  subnet_id     = aws_subnet.public_2a.id

  tags = {
    Name = "K8s-NGW"
  }
}

