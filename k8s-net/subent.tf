resource "aws_subnet" "public_2a" {
  vpc_id     = aws_vpc.k8s_net.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PUBLIC-SUBNET-2A"
  }
}

resource "aws_subnet" "public_2b" {
  vpc_id     = aws_vpc.k8s_net.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "PUBLIC-SUBNET-2B"
  }
}

resource "aws_subnet" "private_2a" {
  vpc_id     = aws_vpc.k8s_net.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "PRIVATE-SUBNET-2A"
  }
}

resource "aws_subnet" "private_2b" {
  vpc_id     = aws_vpc.k8s_net.id
  cidr_block = "192.168.4.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "PRIVATE-SUBNET-2B"
  }
}