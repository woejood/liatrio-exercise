# Liatrio API Deployment
Deployments for the Liatrio API Exercise. This will consist of a Docker container and terraform code to build the Kubernetes cluster in Azure.

### Docker Container
Built using Ubuntu and including python3 and pip. 

### Kubernetes Cluster
Using AKS, the terraform code uses the azurerm, kubernetes, and tls providers to create the necessary resoruces to support deployment of the API container. If a resource group name or subnet ID are not provided in the tfvars file, they will be created, otherwise terraform will only create the AKS cluster. SSH public/private keypairs are generated using the tls provider and placed in outputs called public_key and private_key, respectively.