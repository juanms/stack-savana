# ECS Fargate Infrastructure with Terraform

## Architecture Overview

This infrastructure deploys a containerized web application (Nginx) on AWS ECS Fargate with the following components:

- VPC with public and private subnets across 2 AZs
- Application Load Balancer in public subnets
- ECS Fargate cluster in private subnets
- CloudWatch logging and monitoring
- KMS encryption for sensitive data

### Security Considerations

1. Network Security:
   - Private subnets for ECS tasks
   - Public subnets only for ALB
   - Public IP assignment for container image pulls
   - Security groups limiting access to required ports

2. Access Control:
   - Fine-grained IAM roles for ECS tasks
   - KMS encryption for logs and sensitive data
   - Security groups with least privilege access
   - HTTP/80 access on ALB

3. Monitoring:
   - CloudWatch logs for containers
   - Container insights enabled
   - Custom CloudWatch dashboard
   - SNS notifications for alarms

### Module Structure

```
stack-savana/
├── main.tf          # Root configuration
├── variables.tf     # Root variables
├── providers.tf     # Provider configuration
├── modules/
│   ├── networking/  # VPC and subnet configuration
│   ├── alb/        # Load balancer configuration
│   ├── ecs/        # ECS cluster and service
│   ├── kms/        # KMS key management
│   └── monitoring/ # CloudWatch configuration
```

### Prerequisites

- AWS CLI configured
- Terraform >= 1.0
- AWS account with appropriate permissions
- Create a `terraform.tfvars` file to provide values for variables, or modify the variables directly in `variables.tf`. Example `terraform.tfvars`:
  ```hcl
  environment         = "production"
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones   = ["eu-west-1a", "eu-west-1b"]
  aws_region           = "eu-west-1"
  app_name             = "my-app"
  ```
  Alternatively, pass variables via the `-var` flag during `terraform apply`.

### Deployment Instructions

1. Initialize Terraform:
```bash
terraform init
```

2. Review the plan:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

4. Verify deployment:
   - Check ECS service status in AWS Console
   - Verify ALB health checks
   - Test application access via ALB DNS name

### Cleanup

To destroy the infrastructure:
```bash
terraform destroy
```

### Additional Features

1. Logging:
   - Centralized logging with CloudWatch
   - KMS encryption for log groups
   - Customizable log retention (default: 30 days)

2. Monitoring:
   - CPU and Memory utilization metrics
   - Custom CloudWatch dashboard
   - SNS alerts for critical metrics

3. Security:
   - KMS encryption for sensitive data
   - IAM roles with least privilege
   - Security groups for network isolation

### Known Limitations

- Currently uses HTTP (port 80) for ALB
- Public IP assignment required for container image pulls
- Uses default VPC subnets

### Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request