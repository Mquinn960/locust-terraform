resource "docker_container" "locust_master" {
  image = "locust-test/mqlocust"
  name  = "locust_master"
  restart = "always"
  volumes {
    container_path  = "/mnt/locust"
    host_path = "/home/matt/dev/locust-terraform/shared/locust-files/foobar" 
    read_only = false
  }
  ports {
    internal = 8089
    external = 8089
  }
}