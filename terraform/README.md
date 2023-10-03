# Azure Terraform 

## Pre-requisites

1. azure CLI


1. Login with CLI `az login --use-device-code --tentant xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`
2. Add TENANT ID to `terraform.tfvars` you can get this from `az account list`
3. Run `terraform init` , `terraform plan` then `terraform apply -auto-approve`