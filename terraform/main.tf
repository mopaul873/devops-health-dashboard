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

# Security Group
resource "aws_security_group" "dashboard_sg" {
  name        = "dashboard-sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
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

  tags = {
    Name = "dashboard-sg"
  }
}

# EC2 Instance
resource "aws_instance" "dashboard" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.dashboard_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install python3 python3-pip git -y
    pip3 install flask psutil gunicorn
    cd /home/ec2-user
    git clone https://github.com/mopaul873/devops-health-dashboard.git
    cd devops-health-dashboard
    gunicorn -w 2 -b 0.0.0.0:80 "app.routes:app" --daemon
  EOF

  tags = {
    Name        = "DevOps-Health-Dashboard"
    Environment = "production"
    Project     = "devops-health-dashboard"
  }
}