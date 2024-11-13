provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
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
  ami                    = "ami-0c55b159cbfafe1f0" # AMI Ubuntu
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  security_groups        = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "TechShop-Instance"
  }
}



