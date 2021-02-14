output "master_public_dns" {
  description = "List of public DNS names assigned to the server"
  value       = aws_instance.locust_master.*.public_dns
}

output "master_public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.locust_master.*.public_ip
}