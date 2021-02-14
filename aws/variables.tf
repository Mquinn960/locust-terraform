# AWS
variable "region" {
  default     = "eu-west-2"
}

# Meta
variable "project" {
  default = "locust_demo"
}

variable "project_tag" {
  default = "fd_locust_demo_2021"
}

# Locust
variable "master_host" {
  default = "locust-master"
}

variable "endpoint_host" {
  default = "http://example.com"
}

variable "worker_scale" {
  default = 1
}

variable "locustfile_web_link" {}

# Mockserver
variable "mock_hostname" {
  default = "mock-server"
}

variable "mockserver_init_web_link" {}

variable "ssh_key_name" {}