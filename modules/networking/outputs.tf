output "vpc_id" {
  description = "ID of the default VPC"
  value       = data.aws_vpc.default.id
}

output "public_subnets" {
  description = "IDs of existing public subnets"
  value       = sort(data.aws_subnets.default.ids)
}

output "private_subnets_cidrs" {
  description = "CIDR blocks of private subnets"
  value       = var.private_subnet_cidrs
}

output "availability_zones" {
  description = "AZs used in the VPC"
  value       = var.availability_zones
}