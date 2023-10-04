# Azure Terraform 

## Pre-requisites

1. azure CLI


1. Login with CLI `az login --use-device-code --tentant xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`
2. Add TENANT ID and addmin password to `terraform.tfvars` you can get TENANT ID from `az account list`.

example
```
ARM_TENANT_ID="00000000-0000-0000-0000-00000000000"
admin_password = "Supersecret123"
```

3. Run `terraform init` , `terraform fmt`, `terraform plan` then `terraform apply -auto-approve`