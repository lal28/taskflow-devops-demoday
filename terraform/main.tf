terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Security Group - permite SSH e porta 3000
resource "aws_security_group" "taskflow_sg" {
  name        = "taskflow-api-sg"
  description = "Security group para TaskFlow API"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "API"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "taskflow-sg"
  }
}

# Chave SSH
resource "aws_key_pair" "taskflow_key" {
  key_name   = "taskflow-key"
  public_key = file(var.ssh_public_key_path)
}

# EC2 Instance
resource "aws_instance" "taskflow_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.taskflow_key.key_name
  
  vpc_security_group_ids = [aws_security_group.taskflow_sg.id]

  tags = {
    Name = "taskflow-api-server"
  }

  root_block_device {
    volume_size = 20
  }
}