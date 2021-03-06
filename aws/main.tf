module "network" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = var.project_tag
  cidr                 = "10.10.0.0/16"
  azs                  = ["eu-west-2a"]
  public_subnets       = ["10.10.0.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

module "locust_master" {
  source                = "./locust_master"

  name                  = var.project
  subnet_id             = element(module.network.public_subnets, 0)
  vpc_id                = module.network.vpc_id

  master_host           = var.master_host
  endpoint_host         = var.endpoint_host
  ssh_key_name          = var.ssh_key_name
  locustfile_web_link   = var.locustfile_web_link
  cluster_cidr          = module.network.vpc_cidr_block
  mock_hostname         = module.mock_server.mockserver_public_dns

  project               = var.project
  project_tag           = var.project_tag
}

module "locust_worker" {
  source                = "./locust_worker"

  name                  = var.project
  subnet_id             = element(module.network.public_subnets, 0)
  vpc_id                = module.network.vpc_id

  worker_scale          = var.worker_scale
  master_host           = var.master_host
  ssh_key_name          = var.ssh_key_name
  locustfile_web_link   = var.locustfile_web_link
  master_hostname       = module.locust_master.master_public_dns
  cluster_cidr          = module.network.vpc_cidr_block

  project               = var.project
  project_tag           = var.project_tag
}

module "mock_server" {
  source                    = "./mock_server"

  name                      = var.project
  subnet_id                 = element(module.network.public_subnets, 0)
  vpc_id                    = module.network.vpc_id

  ssh_key_name              = var.ssh_key_name
  mockserver_init_web_link  = var.mockserver_init_web_link
  cluster_cidr              = module.network.vpc_cidr_block

  project                   = var.project
  project_tag               = var.project_tag
}
