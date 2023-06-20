
resource "aws_vpc" "main" {
  cidr_block       = var.mycidr
  instance_tenancy = "default"
  tags = {
    Name = "myvpc"
  }
}
resource "aws_subnet" "pubsubnet_cidr" {

  for_each          = var.pubsubnet_cidr
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["availability_zone"]
  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "private_cidr" {


  vpc_id     = aws_vpc.main.id
  cidr_block = var.private-cidr
  tags = {
    Name = "Main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-igw"
  }
}


resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "publicRT-table"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = "privateRT-table"
  }
}

resource "aws_route_table_association" "a" {
  for_each       = aws_subnet.pubsubnet_cidr
  subnet_id      = each.value.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private_cidr.id
  route_table_id = aws_route_table.private-rt.id
}
