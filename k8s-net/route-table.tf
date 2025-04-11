resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.k8s_net.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s_igw.id
  }

  tags = {
    Name = "K8s-Public-RT"
  }
}

resource "aws_route_table_association" "public_2a_assoc" {
  subnet_id      = aws_subnet.public_2a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2b-assoc" {
  subnet_id      = aws_subnet.public_2b.id
  route_table_id = aws_route_table.public_rt.id
}





resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.k8s_net.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.k8s_ngw.id
  }

  tags = {
    Name = "K8s-Private-RT"
  }
}

resource "aws_route_table_association" "private_2a_assoc" {
  subnet_id      = aws_subnet.private_2a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_2b_assoc" {
  subnet_id      = aws_subnet.private_2b.id
  route_table_id = aws_route_table.private_rt.id
}
