variable "aws_region" {
  type        = string
  description = "AWS region for deployment. No default on purpose: the account SCP only allows us-east-2, pass it per environment."
}

variable "environment" {
  type        = string
  description = "Deployment environment (devel or stage). Must match the selected Terraform workspace."

  validation {
    condition     = contains(["devel", "stage"], var.environment)
    error_message = "environment must be devel or stage."
  }
}

variable "app_name" {
  type        = string
  description = "Application name"
  default     = "rdicidr"
}

variable "image_tag" {
  type        = string
  description = "Tag of the image in the ECR repository managed here. Pass the git SHA at deploy time."
  default     = "latest"
}

variable "container_port" {
  type        = number
  description = "Port the container listens on"
  default     = 80
}

variable "health_check_path" {
  type        = string
  description = "Health check endpoint path"
  default     = "/healthz"
}

variable "desired_count" {
  type        = number
  description = "Number of ECS tasks to run"
  default     = 2
}
