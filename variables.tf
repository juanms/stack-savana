variable "environment" {
  description = "Environment name"
  type        = string
  default     = "test"
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["172.31.64.0/20", "172.31.80.0/20"] 
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "nginx-app"
}

