resource "aws_security_group" "locust_worker" {
  name        = "locust_worker"
  description = "Locust worker specific ACLs"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.project_tag
  }
}

resource "aws_security_group_rule" "allow_cluster_chatter_in" {
    type = "ingress"
    from_port = 5557
    to_port = 5557
    protocol = "tcp"
    cidr_blocks = [var.cluster_cidr]
    security_group_id = aws_security_group.locust_worker.id
}

resource "aws_security_group_rule" "allow_cluster_chatter_out" {
    type = "egress"
    from_port = 5557
    to_port = 5557
    protocol = "tcp"
    cidr_blocks = [var.cluster_cidr]
    security_group_id = aws_security_group.locust_worker.id
}

resource "aws_security_group_rule" "allow_external_egress" {
    type = "egress"
    from_port = 0
    to_port = 65535
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.locust_worker.id
}

resource "aws_security_group_rule" "allow_ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [file("../shared/mq_pub_ip.txt")]
    security_group_id = aws_security_group.locust_worker.id
}

resource "aws_security_group_rule" "http_in" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.locust_worker.id
}

resource "aws_security_group_rule" "https_in" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.locust_worker.id
}

locals {
  userdata_script  = templatefile("resources/locust_worker.sh", {
      locustfile_web_link = var.locustfile_web_link
      master_hostname = var.master_hostname[0]
    })
}

resource "aws_instance" "locust_worker" {
    ami              = var.worker_ami
    instance_type    = var.worker_instance_type
    security_groups  = [ aws_security_group.locust_worker.id ]
    subnet_id        = var.subnet_id
    key_name         = var.ssh_key_name
    count            = var.worker_scale

    tags = {
        Name = "${var.project}_worker_${count.index}"
    }

    user_data        = local.userdata_script    

}