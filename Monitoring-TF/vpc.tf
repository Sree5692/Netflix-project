data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc-name]
  }
}

data "aws_internet_gateway" "igw" {
  filter {
    name   = "tag:Name"
    values = [var.igw-name]
  }
}

data "aws_subnet" "subnet" {
  filter {
    name   = "tag:Name"
    values = [var.subnet-name]
  }
}

data "aws_security_group" "sg-default" {
  filter {
    name   = "tag:Name"
    values = [var.security-group-name]
  }
}

resource "aws_subnet" "public-subnet3" {
  vpc_id                  = data.aws_vpc.vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet-name3
  }
}

resource "aws_route_table" "rt3" {
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rt-name3
  }
}

resource "aws_route_table_association" "rt-association3" {
  route_table_id = aws_route_table.rt3.id
  subnet_id      = aws_subnet.public-subnet3.id
}