output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "cloudwatch_log_group" {
  description = "Name of the CloudWatch log group"
  value       = module.monitoring.log_group_name
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}