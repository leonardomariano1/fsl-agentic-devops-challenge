# stage environment. Use with the matching workspace:
#   terraform workspace select stage
#   terraform apply -var-file=envs/stage.tfvars -var image_tag=<git sha>
environment       = "stage"
aws_region        = "us-east-2"
container_port    = 80
desired_count     = 2
