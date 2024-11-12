provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# VPC configuration
resource "aws_vpc" "techshop_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Subnet configuration
resource "aws_subnet" "techshop_subnet" {
  vpc_id            = aws_vpc.techshop_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

# Security group configuration
resource "aws_security_group" "techshop_sg" {
  vpc_id = aws_vpc.techshop_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance configuration
resource "aws_instance" "techshop_instance" {
  ami                         = "ami-0866a3c8686eaeeba"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.techshop_subnet.id
  vpc_security_group_ids =    [aws_security_group.techshop_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "TechShop-Instance"
  }
}



