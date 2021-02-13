module "network" {
  source = "../../tfmodules/network"
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
    name = module.network.locust_network
  }

  ports {
    internal = 8089
    external = 8089
  }

}

resource "docker_container" "locust_worker" {
  image = "locust-test/mqlocust"
  name  = "locust_worker_${count.index}"
  restart = "always"
  command = ["-f", "/mnt/locust/locustfile.py", "--worker", "--master-host", "locust-master"]

  count = var.worker_scale

  networks_advanced {
    name = module.network.locust_network
  }

  volumes {
    container_path  = "/mnt/locust"
    host_path = "/home/matt/dev/locust-terraform/shared/locust-files/foobar" 
    read_only = false
  }
}

resource "docker_container" "mock_server" {
  image     = "mock-test/mqmock"
  name      = "mock-server"
  hostname  = "mock-server"
  restart   = "always"
  
  env       = ["MOCKSERVER_PROPERTY_FILE=/config/mockserver.properties", "MOCKSERVER_INITIALIZATION_JSON_PATH=/config/initializerJson.json"]

  volumes {
    container_path  = "/config"
    host_path = "/home/matt/dev/locust-terraform/shared/mockserver" 
    read_only = false
  }

  networks_advanced {
    name = module.network.locust_network
  }

  ports {
    internal = 1080
    external = 1080
  }

}