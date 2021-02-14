resource "aws_security_group" "locust_master" {
  name        = "locust_master"
  description = "Locust master specific ACLs"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.project_tag
  }
}

resource "aws_security_group_rule" "allow_ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.locust_master.id
}

resource "aws_security_group_rule" "allow_locust_ui_external" {
    type = "ingress"
    from_port = 8089
    to_port = 8089
    protocol = "tcp"
    cidr_blocks = [file("../shared/mq_pub_ip.txt")]
    security_group_id = aws_security_group.locust_master.id
}

resource "aws_security_group_rule" "allow_cluster_chatter" {
    type = "egress"
    from_port = 5557
    to_port = 5558
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.locust_master.id
}

resource "aws_instance" "locust_master" {
    ami                         = var.master_ami
    instance_type               = var.master_instance_type
    security_groups             = [ aws_security_group.locust_master.id ]
    subnet_id                   = var.subnet_id
    key_name                    = var.ssh_key_name
    associate_public_ip_address = true

    tags = {
        Name = var.project_tag
    }
}