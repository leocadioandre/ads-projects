# Output the public IP of the EC2 instance
output "ec2_public_ip" {
  value       = aws_instance.techshop_instance.public_ip
  description = "The public IP address of the TechShop EC2 instance."
}