# Deployment Guide - Terraform AWS EC2 Base Modules

This guide explains how to deploy and use the child modules from this repository.

## 📋 Prerequisites

1. **Terraform** (>= 1.0)
2. **AWS CLI** configured with appropriate credentials
3. **Git** for cloning the repository
4. **AWS Account** with appropriate permissions

## 🚀 Quick Deployment

### 1. Clone the Repository

```bash
git clone https://github.com/satya12sahoo/terraform-aws-ec2-base.git
cd terraform-aws-ec2-base
```

### 2. Choose a Module

Navigate to the module you want to use:

```bash
cd iam/          # For IAM roles and instance profiles
cd cloudwatch/   # For CloudWatch log groups and scheduling
cd vpc-endpoints/ # For VPC endpoints
cd load-balancer/ # For Application Load Balancers
cd autoscaling/  # For Auto Scaling Groups
cd security-groups/ # For Security Groups
```

### 3. Configure Variables

Create a `terraform.tfvars` file with your configuration:

```hcl
# Example for IAM module
create_instance_profile_for_existing_role = true
instance_profile_name                     = "my-instance-profile"
instance_profile_path                     = "/"
instance_profile_description              = "Instance profile for my application"

tags = {
  Environment = "production"
  Project     = "my-app"
  Owner       = "devops-team"
}
```

### 4. Initialize and Apply

```bash
terraform init
terraform plan
terraform apply
```

## 📦 Module-Specific Deployment

### IAM Module

```bash
cd iam/

# Create terraform.tfvars
cat > terraform.tfvars << EOF
create_instance_profile_for_existing_role = true
instance_profile_name                     = "web-server-profile"
instance_profile_path                     = "/"
instance_profile_description              = "Web server instance profile"
enable_instance_profile_rotation          = true

tags = {
  Environment = "production"
  Project     = "web-app"
}
EOF

terraform init
terraform plan
terraform apply
```

### CloudWatch Module

```bash
cd cloudwatch/

# Create terraform.tfvars
cat > terraform.tfvars << EOF
create_log_group = true
log_group_name   = "/aws/ec2/web-server"
log_retention_days = 30

create_scheduling = true
schedule_rule_name = "web-server-schedule"
schedule_expression = "cron(0 8 * * ? *)"  # Start at 8 AM daily
schedule_timezone = "UTC"

tags = {
  Environment = "production"
  Project     = "web-app"
}
EOF

terraform init
terraform plan
terraform apply
```

### Security Groups Module

```bash
cd security-groups/

# Create terraform.tfvars
cat > terraform.tfvars << EOF
create_security_group = true
security_group_name   = "web-server-sg"
security_group_description = "Security group for web servers"
vpc_id                = "vpc-12345678"

enable_common_ingress_rules = true

tags = {
  Environment = "production"
  Project     = "web-app"
}
EOF

terraform init
terraform plan
terraform apply
```

## 🔧 Advanced Usage

### Using Modules as Dependencies

You can use outputs from one module as inputs to another:

```hcl
# First, deploy IAM module
cd iam/
terraform apply

# Get the instance profile ARN
INSTANCE_PROFILE_ARN=$(terraform output -raw instance_profile_arn)

# Use it in another module
cd ../cloudwatch/
echo "instance_profile_arn = \"$INSTANCE_PROFILE_ARN\"" >> terraform.tfvars
terraform apply
```

### Multi-Module Deployment

Create a main configuration that uses multiple modules:

```hcl
# main.tf
module "iam" {
  source = "./iam"
  
  create_instance_profile_for_existing_role = true
  instance_profile_name                     = "web-server-profile"
  
  tags = local.common_tags
}

module "security_groups" {
  source = "./security-groups"
  
  create_security_group = true
  security_group_name   = "web-server-sg"
  vpc_id                = var.vpc_id
  
  tags = local.common_tags
}

module "cloudwatch" {
  source = "./cloudwatch"
  
  create_log_group = true
  log_group_name   = "/aws/ec2/web-server"
  
  tags = local.common_tags
}

locals {
  common_tags = {
    Environment = "production"
    Project     = "web-app"
  }
}
```

## 🔍 Troubleshooting

### Common Issues

1. **Permission Denied**
   ```bash
   # Ensure AWS credentials are configured
   aws configure
   aws sts get-caller-identity
   ```

2. **Module Not Found**
   ```bash
   # Ensure you're in the correct directory
   pwd
   ls -la
   ```

3. **Variable Validation Errors**
   ```bash
   # Check variable definitions
   terraform validate
   ```

### Debug Commands

```bash
# Validate configuration
terraform validate

# Check what will be created
terraform plan -detailed-exitcode

# Show current state
terraform show

# List resources
terraform state list
```

## 🧹 Cleanup

To destroy resources created by a module:

```bash
# Navigate to module directory
cd iam/

# Destroy resources
terraform destroy

# Or destroy specific resources
terraform destroy -target=aws_iam_instance_profile.main
```

## 📚 Best Practices

1. **Use Version Control**
   - Always commit your Terraform configurations
   - Use meaningful commit messages
   - Tag releases for production deployments

2. **State Management**
   - Use remote state storage (S3 + DynamoDB)
   - Enable state locking
   - Use workspaces for different environments

3. **Security**
   - Use least privilege IAM policies
   - Enable CloudTrail for audit logging
   - Use KMS encryption for sensitive data

4. **Cost Optimization**
   - Use appropriate instance types
   - Enable auto scaling where applicable
   - Use spot instances for non-critical workloads

## 🔗 Related Documentation

- [Module Documentation](README.md)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)

## 🆘 Support

If you encounter issues:

1. Check the [troubleshooting section](#troubleshooting)
2. Review the module-specific documentation
3. Create an issue in the repository
4. Check Terraform and AWS provider documentation
