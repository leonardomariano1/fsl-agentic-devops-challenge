# devel environment. Use with the matching workspace:
#   terraform workspace select devel
#   terraform apply -var-file=envs/devel.tfvars -var image_tag=<git sha>
environment       = "devel"
aws_region        = "us-east-2"
container_port    = 80
desired_count     = 2
