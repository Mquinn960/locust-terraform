# Locust Terraform Demo

This repository contains various approaches to running a
Locust cluster for testing purposes using Terraform.

This is a minimal setup containing a variable number of
Locust workers, with a dummy endpoint to catch and validate
API requests.

## Docker

This setup creates a docker stack via the Kreuzwerker
Docker provider. The demo setup creates a master node and
a variable number of workers as well as a MockServer endpoint
container.

To run the stack, first add a ```locustfile.py``` to the
```/shared``` folder, for demo purposes you can use the
```locust-files``` repo here: https://github.com/Mquinn960/locust-files

To configure the endpoint MockServer instance, you'll need
to add initialisation files - such as the ones here:
https://github.com/Mquinn960/locust-docker-compose/tree/develop/build/mockserver/resources
to the folder being mapped from the local host.

Run ```sudo terraform apply``` to run up the stack and
you should be able to access the endpoint at http://localhost:8089

Then, you can aim your requests at http://mock-server:1080 to 
begin load testing.

## AWS