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

This Terraform stack contains a main build which creates
a shared VPC, before provisioning Locust master and workers as
well as a MockServer endpoint for live load-testing.

This stack allows for a dynamic number of Locust worker nodes
by configuring the ```terraform.tfvars``` config file and
altering the ```worker_scale``` parameter.

### Prerequisites

In order to successfully deploy to your own AWS account, you must
first ensure the following steps have been completed:

- Install Terraform
  - Ensure this is present on your PATH
- Install the AWS CLI
  - Ensure this is present on your PATH
  - Run ```aws configure``` and add your desired access key(s)
    which will be used for configuration

### Running the Stack

- ```cd aws```
  - Move to the AWS stack folder
- ```terraform init```
  - Install required TF modules from their respective definitions
- ```terraform plan```
  - Outline the plan for creating the AWS stack (for validation)
- ```terraform apply```
  - Apply the config to create this demo resource on AWS
  - Respond ```yes``` in order to instantiate the configuration

