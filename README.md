# Terraform AWS EC2 Base Modules

This repository contains reusable Terraform child modules for AWS EC2 infrastructure components. These modules are designed to be used as building blocks in larger infrastructure deployments.

## 📋 Table of Contents

- [Overview](#overview)
- [Modules](#modules)
- [Usage](#usage)
- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

This repository provides modular, reusable Terraform modules for AWS EC2 infrastructure components. Each module is designed to create a single resource or a small group of related resources, following the principle of single responsibility.

## 📦 Modules

### 1. IAM Module (`iam/`)
Creates IAM roles, instance profiles, and policies for EC2 instances.

**Features:**
- IAM Role creation with custom policies
- Instance Profile creation
- Role rotation support
- Custom tags and descriptions

### 2. CloudWatch Module (`cloudwatch/`)
Manages CloudWatch log groups and EventBridge scheduling.

**Features:**
- CloudWatch Log Group creation
- EventBridge rules for scheduling
- Custom retention policies
- KMS encryption support

### 3. VPC Endpoints Module (`vpc-endpoints/`)
Creates VPC endpoints for private AWS service access.

**Features:**
- Multiple endpoint types (S3, EC2, etc.)
- Security group association
- Custom endpoint policies

### 4. Load Balancer Module (`load-balancer/`)
Manages Application Load Balancers and target groups.

**Features:**
- ALB creation with listeners
- Target group management
- Health check configuration
- SSL/TLS support

### 5. Auto Scaling Module (`autoscaling/`)
Creates Auto Scaling Groups and related policies.

**Features:**
- Auto Scaling Group creation
- Scaling policies (CPU, memory, custom)
- CloudWatch alarms
- Mixed instances policy

### 6. Security Groups Module (`security-groups/`)
Manages security groups for EC2 instances.

**Features:**
- Custom security group creation
- Common ingress/egress rules
- Tag-based management

### 7. EC2 Instance Module (`ec2-instance/`)
Creates EC2 instances with all associated resources.

**Features:**
- EC2 instance creation with comprehensive configuration
- IAM instance profile creation for existing roles
- Security group creation with custom rules
- Elastic IP creation and association
- Spot instance support
- EBS volume management
- Monitoring and metadata options

## 🚀 Usage

### Basic Usage

```hcl
module "ec2_instance" {
  source = "github.com/satya12sahoo/terraform-aws-ec2-base//ec2-instance"
  
  name       = "my-instance"
  instance_type = "t3.micro"
  ami        = "ami-0c02fb55956c7d316"
  subnet_id  = "subnet-12345678"
  
  tags = {
    Environment = "production"
    Project     = "my-app"
  }
}
```

### Advanced Usage with Multiple Modules

```hcl
# EC2 Instance Module
module "ec2_instance" {
  source = "github.com/satya12sahoo/terraform-aws-ec2-base//ec2-instance"
  
  name       = "web-server"
  instance_type = "t3.medium"
  ami        = "ami-0c02fb55956c7d316"
  subnet_id  = "subnet-12345678"
  
  # IAM Instance Profile
  create_instance_profile_for_existing_role = true
  iam_role_name = "web-server-role"
  instance_profile_name = "web-server-profile"
  
  # Security Group
  create_security_group = true
  security_group_name = "web-server-sg"
  security_group_vpc_id = "vpc-12345678"
  
  tags = local.common_tags
}

# CloudWatch Module
module "cloudwatch" {
  source = "github.com/satya12sahoo/terraform-aws-ec2-base//cloudwatch"
  
  create_log_group = true
  log_group_name   = "/aws/ec2/web-server"
  log_retention_days = 30
  
  tags = local.common_tags
}

# Security Groups Module
module "security_groups" {
  source = "github.com/satya12sahoo/terraform-aws-ec2-base//security-groups"
  
  create_security_group = true
  security_group_name   = "web-server-sg"
  vpc_id                = var.vpc_id
  
  enable_common_ingress_rules = true
  
  tags = local.common_tags
}
```

## 📋 Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## 🔧 Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## 📥 Inputs

Each module has its own set of inputs. Please refer to the individual module directories for detailed input documentation:

- [IAM Module Inputs](iam/README.md#inputs)
- [CloudWatch Module Inputs](cloudwatch/README.md#inputs)
- [VPC Endpoints Module Inputs](vpc-endpoints/README.md#inputs)
- [Load Balancer Module Inputs](load-balancer/README.md#inputs)
- [Auto Scaling Module Inputs](autoscaling/README.md#inputs)
- [Security Groups Module Inputs](security-groups/README.md#inputs)
- [EC2 Instance Module Inputs](ec2-instance/README.md#inputs)

## 📤 Outputs

Each module provides relevant outputs. Please refer to the individual module directories for detailed output documentation:

- [IAM Module Outputs](iam/README.md#outputs)
- [CloudWatch Module Outputs](cloudwatch/README.md#outputs)
- [VPC Endpoints Module Outputs](vpc-endpoints/README.md#outputs)
- [Load Balancer Module Outputs](load-balancer/README.md#outputs)
- [Auto Scaling Module Outputs](autoscaling/README.md#outputs)
- [Security Groups Module Outputs](security-groups/README.md#outputs)
- [EC2 Instance Module Outputs](ec2-instance/README.md#outputs)

## 💡 Examples

### Minimal Example

```hcl
module "basic_ec2" {
  source = "github.com/satya12sahoo/terraform-aws-ec2-base//ec2-instance"
  
  name       = "basic-instance"
  instance_type = "t3.micro"
  ami        = "ami-0c02fb55956c7d316"
  subnet_id  = "subnet-12345678"
}
```

### Production Example

```hcl
locals {
  common_tags = {
    Environment = "production"
    Project     = "my-app"
    Owner       = "devops-team"
  }
}

module "production_ec2" {
  source = "github.com/satya12sahoo/terraform-aws-ec2-base//ec2-instance"
  
  name       = "production-server"
  instance_type = "t3.medium"
  ami        = "ami-0c02fb55956c7d316"
  subnet_id  = "subnet-12345678"
  
  # IAM Instance Profile
  create_instance_profile_for_existing_role = true
  iam_role_name = "production-role"
  instance_profile_name = "production-profile"
  
  # Security Group
  create_security_group = true
  security_group_name = "production-sg"
  security_group_vpc_id = "vpc-12345678"
  
  # Elastic IP
  create_eip = true
  
  tags = local.common_tags
}
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Terraform best practices
- Include comprehensive documentation
- Add examples for each module
- Ensure backward compatibility
- Test with multiple AWS regions

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:

- Create an issue in this repository
- Check the [examples](examples/) directory
- Review the individual module documentation

## 🔗 Related Repositories

- [terraform-aws-ec2-complement](https://github.com/satya12sahoo/terraform-aws-ec2-complement) - Wrapper module and examples
- [terraform-aws-ec2-instance](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance) - Base EC2 instance module

---

**Note:** This repository contains only the child modules. For the complete wrapper module with examples, see the [Complement Repository](https://github.com/your-org/terraform-aws-ec2-complement).
