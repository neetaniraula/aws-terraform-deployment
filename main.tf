# Setup VPC
resource "aws_vpc" "vpc_us_central_aws_terraform" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Setup public subnet
resource "aws_subnet" "public_subnet_aws_terraform" {
  count             = length(var.cidr_public_subnet)
  vpc_id            = aws_vpc.vpc_us_central_aws_terraform.id
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.us_availability_zone, count.index)

  tags = {
    Name = "public-subnet-aws-terraform-${count.index + 1}"
  }
}

# Setup private subnet
resource "aws_subnet" "private_subnet_aws_terraform" {
  count             = length(var.cidr_private_subnet)
  vpc_id            = aws_vpc.vpc_us_central_aws_terraform.id
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.us_availability_zone, count.index)

  tags = {
    Name = "private-subnet-aws-terraform-${count.index + 1}"
  }
}

# Setup Internet Gateway
resource "aws_internet_gateway" "igw_aws_terraform" {
  vpc_id = aws_vpc.vpc_us_central_aws_terraform.id

  tags = {
    Name = "igw-aws-terraform"
  }
}

# Setup public route table
resource "aws_route_table" "public_rt_aws_terraform" {
  vpc_id = aws_vpc.vpc_us_central_aws_terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_aws_terraform.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Public route table and public subnet association
resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.public_subnet_aws_terraform)
  subnet_id      = aws_subnet.public_subnet_aws_terraform[count.index].id
  route_table_id = aws_route_table.public_rt_aws_terraform.id
}

# Setup private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc_us_central_aws_terraform.id

  tags = {
    Name = "private-route-table"
  }
}

# Private route table and private subnet association
resource "aws_route_table_association" "private_rt_association" {
  count          = length(aws_subnet.private_subnet_aws_terraform)
  subnet_id      = aws_subnet.private_subnet_aws_terraform[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

# Create an Elastic IP for the NAT gateway
resource "aws_eip" "nat_eip" {
}

# Create NAT Gateway in the public subnet
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_aws_terraform[0].id

  tags = {
    Name = "nat-gateway"
  }
  depends_on = [aws_internet_gateway.igw_aws_terraform]
}

# Setup the private route table without specifying routes directly
resource "aws_route_table" "nat_private_association" {
  vpc_id = aws_vpc.vpc_us_central_aws_terraform.id

  tags = {
    Name = "Private-route-table"
  }
}

# Add route to the private route table to use NAT Gateway for outbound traffic
resource "aws_route" "nat_route" {
  route_table_id         = aws_route_table.nat_private_association.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

