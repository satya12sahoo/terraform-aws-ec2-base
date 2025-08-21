# Security Groups Module

This module creates and manages AWS security groups for EC2 instances with flexible ingress and egress rule configurations, supporting both custom rules and common predefined rules.

## 🚀 Features

- **Dynamic Rule Configuration**: Flexible ingress and egress rule definitions
- **Common Rule Templates**: Predefined common ingress rules (SSH, HTTP, HTTPS)
- **VPC Integration**: Automatic VPC detection from subnet
- **Rule Validation**: Built-in rule validation and error handling
- **Tag Management**: Comprehensive tagging support
- **Lifecycle Management**: Create before destroy lifecycle policy
- **Conditional Creation**: Toggle security group creation on/off

## 📖 Usage

### Basic Example

```hcl
module "security_group" {
  source = "../security-groups"

  # Enable security group creation
  create_security_group = true
  
  # Basic configuration
  security_group_name = "web-server-sg"
  security_group_description = "Security group for web servers"
  subnet_id = "subnet-12345678"
  
  # Enable common ingress rules
  enable_common_ingress_rules = true
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### Advanced Example with Custom Rules

```hcl
module "security_group" {
  source = "../security-groups"

  create_security_group = true
  
  # Security group configuration
  security_group_name = "database-server-sg"
  security_group_description = "Security group for database servers"
  subnet_id = "subnet-12345678"
  security_group_revoke_rules_on_delete = true
  
  # Custom ingress rules
  security_group_ingress_rules = [
    {
      from_port = 22
      to_port = 22
      ip_protocol = "tcp"
      cidr_ipv4 = "10.0.0.0/16"
      description = "SSH from VPC"
    },
    {
      from_port = 3306
      to_port = 3306
      ip_protocol = "tcp"
      referenced_security_group_id = "sg-web-servers"
      description = "MySQL from web servers"
    },
    {
      from_port = 5432
      to_port = 5432
      ip_protocol = "tcp"
      cidr_ipv4 = "10.0.1.0/24"
      description = "PostgreSQL from app subnet"
    }
  ]
  
  # Custom egress rules
  security_group_egress_rules = [
    {
      from_port = 443
      to_port = 443
      ip_protocol = "tcp"
      cidr_ipv4 = "0.0.0.0/0"
      description = "HTTPS to internet"
    },
    {
      from_port = 80
      to_port = 80
      ip_protocol = "tcp"
      cidr_ipv4 = "0.0.0.0/0"
      description = "HTTP to internet"
    }
  ]
  
  # Disable default egress rule
  default_egress_rule = {
    enabled = false
  }
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "database-system"
  }
  
  security_group_tags = {
    Purpose = "database-access"
    SecurityLevel = "high"
  }
}
```

### Example with Common Rules and Custom Overrides

```hcl
module "security_group" {
  source = "../security-groups"

  create_security_group = true
  
  # Security group configuration
  security_group_name = "app-server-sg"
  security_group_description = "Security group for application servers"
  subnet_id = "subnet-12345678"
  
  # Enable common ingress rules (SSH, HTTP, HTTPS)
  enable_common_ingress_rules = true
  
  # Custom ingress rules in addition to common rules
  security_group_ingress_rules = [
    {
      from_port = 8080
      to_port = 8080
      ip_protocol = "tcp"
      cidr_ipv4 = "10.0.0.0/16"
      description = "Application port from VPC"
    },
    {
      from_port = 9000
      to_port = 9000
      ip_protocol = "tcp"
      referenced_security_group_id = "sg-load-balancer"
      description = "Health check from load balancer"
    }
  ]
  
  # Custom egress rules
  security_group_egress_rules = [
    {
      from_port = 443
      to_port = 443
      ip_protocol = "tcp"
      cidr_ipv4 = "0.0.0.0/0"
      description = "HTTPS to internet"
    },
    {
      from_port = 3306
      to_port = 3306
      ip_protocol = "tcp"
      referenced_security_group_id = "sg-database"
      description = "Database access"
    }
  ]
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "web-application"
  }
}
```

## 📋 Inputs

### Security Group Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_security_group` | Whether to create a security group | `bool` | `false` | no |
| `security_group_name` | Name of the security group | `string` | `null` | yes |
| `security_group_name_prefix` | Name prefix for the security group | `string` | `null` | no |
| `security_group_description` | Description of the security group | `string` | `null` | yes |
| `subnet_id` | Subnet ID to determine VPC | `string` | `null` | yes |
| `vpc_id` | VPC ID (optional, will use subnet VPC if not provided) | `string` | `null` | no |
| `security_group_revoke_rules_on_delete` | Whether to revoke rules on delete | `bool` | `false` | no |

### Ingress Rules Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `security_group_ingress_rules` | List of ingress rules | `list(object)` | `[]` | no |
| `enable_common_ingress_rules` | Enable common ingress rules (SSH, HTTP, HTTPS) | `bool` | `false` | no |

### Egress Rules Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `security_group_egress_rules` | List of egress rules | `list(object)` | `[]` | no |
| `default_egress_rule` | Default egress rule configuration | `object` | `{enabled = true, from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"], ipv6_cidr_blocks = ["::/0"], description = "Allow all outbound traffic"}` | no |

### Tagging Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `common_tags` | Common tags to apply to all resources | `map(string)` | `{}` | no |
| `security_group_tags` | Additional tags for the security group | `map(string)` | `{}` | no |

## 📤 Outputs

| Name | Description |
|------|-------------|
| `security_group_id` | ID of the created security group |
| `security_group_arn` | ARN of the created security group |
| `security_group_name` | Name of the created security group |
| `security_group_description` | Description of the created security group |
| `security_group_vpc_id` | VPC ID of the security group |

## 🔧 Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## 🔗 Related Modules

- [terraform-aws-ec2-instance](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance) - EC2 instance module
- [terraform-ec2-wrapper](../terraform-ec2-wrapper) - Wrapper module that uses this security groups module

## 📝 Notes

- Security groups are VPC-specific resources
- Ingress and egress rules can be defined using various source types (CIDR, security group, prefix list)
- Common ingress rules include SSH (22), HTTP (80), and HTTPS (443)
- Default egress rule allows all outbound traffic unless overridden
- Security group names must be unique within a VPC

## 🚨 Important

- Ensure the subnet ID is valid and exists
- Security group rules are stateful (return traffic is automatically allowed)
- Be careful with overly permissive rules in production environments
- Consider using security group references instead of CIDR blocks when possible
- Security groups cannot be deleted if they are attached to running instances
