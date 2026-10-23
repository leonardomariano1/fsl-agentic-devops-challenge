# Terraform (ECS Fargate + ALB + ECR)

State and variables are isolated per environment with Terraform workspaces
and one tfvars file per environment. Only `us-east-2` is allowed by the
account SCP, so the region is always passed explicitly.

```sh
terraform init
terraform workspace select -or-create devel
terraform apply -var-file=envs/devel.tfvars -var image_tag=<git-sha>
```

Build and push the image before the service is applied:

```sh
terraform apply -var-file=envs/devel.tfvars -var image_tag=<git-sha> -target=aws_ecr_repository.app
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin <account>.dkr.ecr.us-east-2.amazonaws.com
docker buildx build --platform linux/amd64 -t <repo-url>:<git-sha> --push ..
```
