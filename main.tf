provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 1}.0/24"
  availability_zone = element(["a", "b", "c"], count.index)
  map_public_ip_on_launch = true
}

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Security group for instances"
  vpc_id      = aws_vpc.main.id

  // Define your security group rules here
  // For example, allow SSH and HTTP traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instance" {
  count         = 2
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = element(aws_subnet.subnet[*].id, count.index)
  security_groups = [aws_security_group.instance_sg.id]
  key_name      = var.key_name
}

