output "dashboard_url" {
  value       = "http://${aws_instance.dashboard.public_ip}"
  description = "URL to access the dashboard"
}

output "instance_id" {
  value       = aws_instance.dashboard.id
  description = "EC2 Instance ID"
}

output "public_ip" {
  value       = aws_instance.dashboard.public_ip
  description = "Public IP of the EC2 instance"
}