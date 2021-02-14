variable "name" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "project_tag" {}
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
