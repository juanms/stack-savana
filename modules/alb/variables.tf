variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "IDs of public subnets"
  type        = list(string)
}

variable "app_port" {
  description = "Port the application listens on"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "Path for ALB health check"
  type        = string
  default     = "/"
}


