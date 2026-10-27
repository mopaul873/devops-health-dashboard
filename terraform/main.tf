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
  description = "Allow HTTP traffic to the dashboard"

  ingress {
    description = "HTTP"
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

  tags = {
    Name = "dashboard-sg"
  }
}

# EC2 Instance
resource "aws_instance" "dashboard" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.dashboard_sg.id]

  # Each deployment passes the commit SHA as app_version. A new SHA
  # changes user_data, which replaces the instance with a fresh one
  # running that exact commit (immutable deployment).
  user_data_replace_on_change = true

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install python3 python3-pip git -y
    pip3 install flask psutil gunicorn
    cd /home/ec2-user
    git clone https://github.com/mopaul873/devops-health-dashboard.git
    cd devops-health-dashboard
    git checkout ${var.app_version}
    gunicorn -w 2 -b 0.0.0.0:80 "app.routes:app" --daemon
  EOF

  tags = {
    Name        = "DevOps-Health-Dashboard"
    Environment = "production"
    Project     = "devops-health-dashboard"
  }
}