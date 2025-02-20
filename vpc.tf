resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Terraform_project"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Terraform_project_igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Terraform_project_Public_sb"
  }
}
resource "aws_subnet" "public-2" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-1c"
  cidr_block        = "10.0.4.0/24"

  tags = {
    Name = "Terraform_project_Public_sb-2"
  }
}

resource "aws_subnet" "private-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "Terraform_project_Private_sb-1"
  }
}
resource "aws_subnet" "private-2" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.3.0/24"

  tags = {
    Name = "Terraform_project_Private_sb-2"
  }
}

# Route-Table for Public Subnet
resource "aws_route_table" "public_SB_RT" {
  vpc_id = aws_vpc.main.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Terraform_project_Public_RT"
  }
}


resource "aws_route_table_association" "public_rt-Asso" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_SB_RT.id
}

resource "aws_route_table_association" "public_rt-Asso2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.public_SB_RT.id
}


# Route-Table for private Subnet 1
resource "aws_route_table" "private_SB_RT-1" {
  vpc_id = aws_vpc.main.id

  route = []

  tags = {
    Name = "Terraform_project_Private_RT-1"
  }
}


resource "aws_route_table_association" "private_rt-Asso-1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.private_SB_RT-1.id
}

# Route-Table for private Subnet 1
resource "aws_route_table" "private_SB_RT-2" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = "Terraform_project_Private_RT-2"
  }
}


resource "aws_route_table_association" "private_rt-Asso-2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.private_SB_RT-2.id
}

resource "aws_eip" "lb" {
  domain = "vpc"
}


# Natgateway setup

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}


resource "aws_route" "natgate_route_pr-sb-1" {
  route_table_id         = aws_route_table.private_SB_RT-1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

resource "aws_route" "natgate_route_pr-sb-2" {
  route_table_id         = aws_route_table.private_SB_RT-2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}