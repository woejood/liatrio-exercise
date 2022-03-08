# Liatrio Interview Exercise
Cloud Native Engineer Interview Exercise

### Application
 A simple python3/Flask REST endpoint that returns a JSON payload with the current timestamp and a static message.

### Enviornment
Application is built into a docker container and will run on a Kubernetes cluster

### Kubernetes
Terraform code is provided to build the Kubernetes cluster in Azure. The code will create the necessary resources to stand up a fully functional dev/test cluster with resource group and virtual network. 

### Prereqs
An active subscription is needed with the subscription ID and tenant ID. A script is provided to create the service principal name in the subscription of your choice. The ClientID/AppID and Password of the SPN will be  used to run the terraform code. 