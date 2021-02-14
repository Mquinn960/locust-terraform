variable "name" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "project_tag" {}
variable "project" {}
variable "ssh_key_name" {}

# Master config
variable endpoint_host {
    type = string
}

variable master_host {
    type = string
}

variable "master_instance_type" {
    default = "t2.micro"
}

variable "master_ami" {
    default = "ami-098828924dc89ea4a"
}

variable "locustfile_web_link" {}

variable "cluster_cidr" {}

# Mockserver
variable "mock_hostname" {
  default = "mock-server"
}
