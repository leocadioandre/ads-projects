provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "techshop_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "techshop_subnet" {
  vpc_id            = aws_vpc.techshop_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

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

resource "aws_instance" "techshop_instance" {
  ami             = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.techshop_subnet.id
  security_groups = [aws_security_group.techshop_sg.name]

  tags = {
    Name = "TechShop-Instance"
  }
}
