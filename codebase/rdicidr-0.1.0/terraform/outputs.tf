output "alb_dns_name" {
  value       = aws_lb.app.dns_name
  description = "DNS name of the load balancer"
}

output "environment" {
  value       = var.environment
  description = "Environment this state belongs to"
}

output "cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "ECS cluster name"
}
