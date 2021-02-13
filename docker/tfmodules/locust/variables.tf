variable "worker_scale" {
  type = string
}

resource "random_id" "id" {
	  byte_length = 8
}