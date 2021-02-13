resource "docker_network" "private_network" {
  name = "locust_net"
}

resource "docker_container" "locust_master" {
  image     = "locust-test/mqlocust"
  name      = "locust-master"
  hostname  = "locust-master"
  restart   = "always"
  command   = ["-f", "/mnt/locust/locustfile.py", "--master", "-H", "http://locust-master:8089"]
  
  volumes {
    container_path  = "/mnt/locust"
    host_path = "/home/matt/dev/locust-terraform/shared/locust-files/foobar" 
    read_only = false
  }

  networks_advanced {
    name = docker_network.private_network.name
  }

  ports {
    internal = 8089
    external = 8089
  }

  ports {
    internal = 5557
    external = 5557
  }

  ports {
    internal = 5558
    external = 5558
  }

}

resource "docker_container" "locust_worker" {
  image = "locust-test/mqlocust"
  name  = "locust_worker_${count.index}"
  restart = "always"
  command = ["-f", "/mnt/locust/locustfile.py", "--worker", "--master-host", "locust-master"]

  count = var.worker_scale

  networks_advanced {
    name = docker_network.private_network.name
  }

  volumes {
    container_path  = "/mnt/locust"
    host_path = "/home/matt/dev/locust-terraform/shared/locust-files/foobar" 
    read_only = false
  }
}