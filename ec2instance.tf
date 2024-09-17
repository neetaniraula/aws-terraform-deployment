# EC2 instance in public subnet
resource "aws_instance" "public_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.public_subnet_aws_terraform[0].id
  associate_public_ip_address = true

  tags = {
    Name = "Public-EC2-Instance"
  }
}
#EC2 instance for private subnet
resource "aws_instance" "private_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.private_subnet_aws_terraform[0].id
  associate_public_ip_address = false  

  tags = {
    Name = "Private-EC2-Instance"
  }
  # Reference the private security group
  vpc_security_group_ids = [aws_security_group.private_sg.id]
}

# Define Security group for Public EC2 Instance
resource "aws_security_group" "public_sg" {
  name   = "public-security-group"
  vpc_id = aws_vpc.vpc_us_central_aws_terraform.id

  # Inbound rule for HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public-Security-Group"
  }
}

# Define Security group for Private EC2 Instance
resource "aws_security_group" "private_sg" {
  name   = "private-security-group"
  vpc_id = aws_vpc.vpc_us_central_aws_terraform.id

  # Inbound rule allowing SSH access from specific sources
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  }

  # Outbound rule allowing all traffic (for NAT Gateway traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private-Security-Group"
  }
}
