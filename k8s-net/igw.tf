resource "aws_internet_gateway" "k8s_igw" {
  vpc_id = aws_vpc.k8s_net.id

  tags = {
    Name = "K8s-NET-IGW"
  }
}