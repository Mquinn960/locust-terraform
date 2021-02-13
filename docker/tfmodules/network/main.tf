resource "docker_network" "private_network" {
  name = "locust_net"
}

output "locust_network" {
    value = docker_network.private_network.name
}