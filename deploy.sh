# script to launch deployment of environment. Kicks off git push to
# trigger container build action and launch aks cluster build. 

git push .

cd deployment/
terraform init
terraform plan
terraform apply

terraform output kube_config