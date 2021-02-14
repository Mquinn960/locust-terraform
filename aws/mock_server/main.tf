resource "aws_security_group" "mock_server" {
  name        = "mock_server"
  description = "Mock Server specific ACLs"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.project_tag
  }
}

resource "aws_security_group_rule" "http_in" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.mock_server.id
}

resource "aws_security_group_rule" "http_out" {
    type = "egress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.mock_server.id
}

resource "aws_security_group_rule" "https_in" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.mock_server.id
}

resource "aws_security_group_rule" "https_out" {
    type = "egress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.mock_server.id
}

resource "aws_security_group_rule" "allow_ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [file("../shared/mq_pub_ip.txt")]
    security_group_id = aws_security_group.mock_server.id
}

locals {
  userdata_script  = templatefile("resources/mock_server.sh", {
        mockserver_init_web_link = var.mockserver_init_web_link
  })
}

resource "aws_instance" "mock_server" {
    ami                         = var.mockserver_ami
    instance_type               = var.mockserver_instance_type
    security_groups             = [ aws_security_group.mock_server.id ]
    subnet_id                   = var.subnet_id
    key_name                    = var.ssh_key_name
    associate_public_ip_address = true

    tags = {
        Name = "mock_server"
    }

    user_data                   = local.userdata_script

}