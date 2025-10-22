provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "vpc_03" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC-03"
  }
}

# Subxarxa pública A
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.vpc_03.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-A"
  }
}

# Subxarxa pública B
resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.vpc_03.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-B"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_03.id
  tags = {
    Name = "IGW-VPC-03"
  }
}

# Taula de rutes pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_03.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-Route-Table"
  }
}

# Associació de taula de rutes amb subxarxes
resource "aws_route_table_association" "public_a_assoc" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b_assoc" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

# Grup de seguretat
resource "aws_security_group" "ec2_sg" {
  name        = "EC2-SG"
  description = "Allow SSH, ICMP from VPC, all outbound"
  vpc_id      = aws_vpc.vpc_03.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP from VPC only"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2-SG"
  }
}

# Instància EC2 A
resource "aws_instance" "ec2_a" {
  ami                    = "ami-052064a798f08f0d3" # Amazon Linux 2023
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_a.id
  key_name               = "vockey"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "ec2-a"
  }
}

# Instància EC2 B
resource "aws_instance" "ec2_b" {
  ami                    = "ami-052064a798f08f0d3"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_b.id
  key_name               = "vockey"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "ec2-b"
  }
}
