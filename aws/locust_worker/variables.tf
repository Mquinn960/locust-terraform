variable "name" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "project_tag" {}
variable "ssh_key_name" {}

# Worker config
variable "worker_scale" {
    type = string
}

variable master_host {
    type = string
}

variable "worker_instance_type" {
    default = "t2.micro"
}

variable "worker_ami" {
    default = "ami-098828924dc89ea4a"
}
