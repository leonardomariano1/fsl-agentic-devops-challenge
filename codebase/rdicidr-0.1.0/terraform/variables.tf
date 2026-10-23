variable "aws_region" {
  type        = string
  description = "AWS region for deployment (set per environment; only us-east-2 is allowed by the account SCP)"
}

variable "environment" {
  type        = string
  description = "Deployment environment (devel or stage); isolates names, vars and workspace state"
}

variable "app_name" {
  type        = string
  description = "Application name"
  default     = "rdicidr"
}

variable "image_tag" {
  type        = string
  description = "Tag of the image in the ECR repository created by this configuration (e.g. the git SHA)"
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
