resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = { Name = "${var.environment}-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.environment}-igw" }
}

# 2 public subnets and 1 private 

resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_1_subnet.cidr_block
  availability_zone = data.aws_availability_zones.zones.names[0]

  tags = { Name = "${var.environment}-public_1-subnet" }
}

resource "aws_subnet" "public_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_2_subnet.cidr_block
  # assign dif availability zones for the 2nd subnet
  availability_zone = data.aws_availability_zones.zones.names[1]

  tags = { Name = "${var.environment}-public_2-subnet" }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet.cidr_block
  availability_zone = data.aws_availability_zones.zones.names[0]

  tags = { Name = "${var.environment}-private-subnet" }
}

# create nat gateway and public ip 
resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = { Name = "${var.environment}-nat_eip" }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id

  tags = { Name = "${var.environment}-nat_gateway" }

  depends_on = [aws_internet_gateway.igw]
}

# public route table for the public subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "${var.environment}-public_rt" }

}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt.id
}

# private route table - only local traffic 
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id # Directs private traffic to the internet safely
  }
  tags = { Name = "${var.environment}-private_rt" }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

