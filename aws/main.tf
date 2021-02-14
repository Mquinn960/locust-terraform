module "network" {
  source = "terraform-aws-modules/vpc/aws"

  name               = var.project_tag
  cidr               = "10.10.0.0/16"
  azs                = ["eu-west-2a"]
  public_subnets     = ["10.10.0.0/24"]
  enable_dns_support = true
}

module "locust_master" {
  source          = "./locust_master"

  name            = var.project
  subnet_id       = element(module.network.public_subnets, 0)
  vpc_id          = module.network.vpc_id

  master_host     = var.master_host
  endpoint_host   = var.endpoint_host
  ssh_key_name    = var.ssh_key_name

  project_tag     = var.project_tag
}

module "locust_worker" {
  source          = "./locust_worker"

  name            = var.project
  subnet_id       = element(module.network.public_subnets, 0)
  vpc_id          = module.network.vpc_id

  worker_scale    = var.worker_scale
  master_host     = var.master_host
  ssh_key_name    = var.ssh_key_name

  project_tag     = var.project_tag
}
