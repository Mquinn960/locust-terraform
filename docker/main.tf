module "locust" {
  source        = "./tfmodules/locust"
  worker_scale  = 3
}
