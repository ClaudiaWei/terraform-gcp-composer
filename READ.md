## Apply changes

pre-requests

* tfenv

dev

```
GOOGLE_APPLICATION_CREDENTIALS=keyfile.json terraform init -backend-config=env/dev/backend.tfvars -reconfigure
GOOGLE_APPLICATION_CREDENTIALS=keyfile.json terraform plan -var-file=env/dev/var.tfvars
GOOGLE_APPLICATION_CREDENTIALS=keyfile.json terraform apply -var-file=env/dev/var.tfvars
```

stage

```
GOOGLE_APPLICATION_CREDENTIALS=keyfile.json terraform init -backend-config=env/stage/backend.tfvars -reconfigure
GOOGLE_APPLICATION_CREDENTIALS=keyfile.json terraform plan -var-file=env/stage/var.tfvars
GOOGLE_APPLICATION_CREDENTIALS=keyfile.json terraform apply -var-file=env/stage/var.tfvars
```

production

```
GOOGLE_APPLICATION_CREDENTIALS=keyfile.json terraform init -backend-config=env/prod/backend.tfvars -reconfigure
GOOGLE_APPLICATION_CREDENTIALS=keyfile.json terraform plan -var-file=env/prod/var.tfvars
GOOGLE_APPLICATION_CREDENTIALS=keyfile.json terraform apply -var-file=env/prod/var.tfvars
```