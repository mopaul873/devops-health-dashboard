variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "app_version" {
  description = "Git commit or branch to deploy (the pipeline passes the commit SHA)"
  default     = "main"
}
