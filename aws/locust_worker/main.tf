resource "aws_security_group" "locust_worker" {
  name        = "locust_worker"
  description = "Locust worker specific ACLs"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.project_tag
  }
}

resource "aws_security_group_rule" "allow_locust" {
    type = "ingress"
    from_port = 8089
    to_port = 8089
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.locust_worker.id
}

resource "aws_security_group_rule" "allow_cluster_chatter" {
    type = "ingress"
    from_port = 5557
    to_port = 5558
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

resource "aws_instance" "locust_worker" {
    ami              = var.worker_ami
    instance_type    = var.worker_instance_type
    security_groups  = [ aws_security_group.locust_worker.id ]
    subnet_id        = var.subnet_id
    key_name         = var.ssh_key_name
    count            = var.worker_scale

    tags = {
        Name = var.project_tag
    }

    # userdata = ["locust", "-f", "/mnt/locust/locustfile.py", "--worker", "--master-host", "locust-master"]
}