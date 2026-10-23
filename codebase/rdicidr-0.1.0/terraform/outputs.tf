output "alb_dns_name" {
  value       = aws_lb.app.dns_name
  description = "DNS name of the load balancer"
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.app.repository_url
  description = "ECR repository the task definition pulls from"
}

output "cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "ECS cluster name"
}

output "service_name" {
  value       = aws_ecs_service.app.name
  description = "ECS service name"
}

output "alb_url" {
  value       = "http://${aws_lb.app.dns_name}"
  description = "Public URL of the application"
}
