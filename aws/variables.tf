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
  default = 2
}

variable "ssh_key_name" {}