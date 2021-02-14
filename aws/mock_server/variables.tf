variable "name" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "project_tag" {}
variable "project" {}
variable "ssh_key_name" {}

variable "mockserver_instance_type" {
    default = "t2.micro"
}

variable "mockserver_ami" {
    default = "ami-098828924dc89ea4a"
}

variable "mockserver_init_web_link" {}

variable "cluster_cidr" {}