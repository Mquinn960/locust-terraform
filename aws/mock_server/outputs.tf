output "mockserver_public_dns" {
  description = "List of public DNS names assigned to the server"
  value       = aws_instance.mock_server.*.public_dns
}

output "mockserver_public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.mock_server.*.public_ip
}