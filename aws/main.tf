module "network" {
  source = "./network"

  cidr               = "10.0.0.0/16"
  project_tag        = var.project_tag
}

module "locust" {
    source = "./locust"

    worker_scale = 1
}