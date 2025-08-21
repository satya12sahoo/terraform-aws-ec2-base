# Load Balancer Module

This module creates Application Load Balancers (ALB) with target groups, listeners, and security groups for EC2 instances, providing load balancing and health checking capabilities.

## 🚀 Features

- **Application Load Balancer**: Create ALB with configurable settings
- **Target Group Management**: Automatic target group creation with health checks
- **Listener Configuration**: HTTP/HTTPS listener setup
- **Security Group Integration**: Dedicated security group for load balancer
- **Health Check Configuration**: Customizable health check parameters
- **Cross-Zone Load Balancing**: Enable/disable cross-zone load balancing
- **Deletion Protection**: Protect load balancer from accidental deletion
- **Tag Management**: Comprehensive tagging support
- **Conditional Creation**: Toggle load balancer creation on/off

## 📖 Usage

### Basic Example

```hcl
module "load_balancer" {
  source = "../load-balancer"

  # Enable load balancer creation
  create_load_balancer = true
  
  # Basic configuration
  load_balancer_name = "web-alb"
  load_balancer_description = "Application Load Balancer for web servers"
  subnet_id = "subnet-12345678"
  
  # Target group configuration
  target_group_name = "web-target-group"
  target_group_port = 80
  target_group_protocol = "HTTP"
  
  # Listener configuration
  listener_port = 80
  listener_protocol = "HTTP"
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### Advanced Example with HTTPS

```hcl
module "load_balancer" {
  source = "../load-balancer"

  create_load_balancer = true
  
  # Load balancer configuration
  load_balancer_name = "secure-web-alb"
  load_balancer_description = "Secure Application Load Balancer for web servers"
  load_balancer_internal = false
  load_balancer_type = "application"
  subnet_id = "subnet-12345678"
  
  # Advanced load balancer settings
  enable_deletion_protection = true
  enable_cross_zone_load_balancing = true
  idle_timeout = 60
  
  # Target group configuration
  target_group_name = "web-target-group"
  target_group_port = 80
  target_group_protocol = "HTTP"
  target_group_target_type = "instance"
  target_group_description = "Target group for web servers"
  
  # Health check configuration
  health_check_enabled = true
  health_check_healthy_threshold = 2
  health_check_interval = 30
  health_check_matcher = "200"
  health_check_path = "/health"
  health_check_port = "80"
  health_check_protocol = "HTTP"
  health_check_timeout = 5
  health_check_unhealthy_threshold = 3
  
  # Listener configuration
  listener_port = 443
  listener_protocol = "HTTPS"
  listener_default_action_type = "forward"
  
  # Security group rules
  security_group_name = "alb-security-group"
  security_group_description = "Security group for ALB"
  security_group_rules = [
    {
      type = "ingress"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP from internet"
    },
    {
      type = "ingress"
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS from internet"
    },
    {
      type = "egress"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "All outbound traffic"
    }
  ]
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "web-application"
    SecurityLevel = "high"
  }
}
```

### Internal Load Balancer Example

```hcl
module "internal_load_balancer" {
  source = "../load-balancer"

  create_load_balancer = true
  
  # Internal load balancer configuration
  load_balancer_name = "internal-api-alb"
  load_balancer_description = "Internal ALB for API servers"
  load_balancer_internal = true
  load_balancer_type = "application"
  subnet_id = "subnet-private-12345678"
  
  # Target group configuration
  target_group_name = "api-target-group"
  target_group_port = 8080
  target_group_protocol = "HTTP"
  target_group_target_type = "instance"
  
  # Health check configuration
  health_check_enabled = true
  health_check_healthy_threshold = 2
  health_check_interval = 30
  health_check_matcher = "200,302"
  health_check_path = "/api/health"
  health_check_port = "8080"
  health_check_protocol = "HTTP"
  health_check_timeout = 10
  health_check_unhealthy_threshold = 3
  
  # Listener configuration
  listener_port = 80
  listener_protocol = "HTTP"
  
  # Security group rules for internal access
  security_group_name = "internal-alb-sg"
  security_group_description = "Security group for internal ALB"
  security_group_rules = [
    {
      type = "ingress"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
      description = "HTTP from VPC"
    },
    {
      type = "egress"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "All outbound traffic"
    }
  ]
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "api-system"
    NetworkType = "internal"
  }
}
```

## 📋 Inputs

### Load Balancer Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_load_balancer` | Whether to create a load balancer | `bool` | `false` | no |
| `load_balancer_name` | Name of the load balancer | `string` | `null` | yes |
| `load_balancer_description` | Description of the load balancer | `string` | `null` | no |
| `load_balancer_internal` | Whether the load balancer is internal | `bool` | `false` | no |
| `load_balancer_type` | Type of load balancer | `string` | `"application"` | no |
| `subnet_id` | Subnet ID for the load balancer | `string` | `null` | yes |
| `enable_deletion_protection` | Enable deletion protection | `bool` | `false` | no |
| `enable_cross_zone_load_balancing` | Enable cross-zone load balancing | `bool` | `true` | no |
| `idle_timeout` | Idle timeout in seconds | `number` | `60` | no |

### Target Group Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `target_group_name` | Name of the target group | `string` | `null` | yes |
| `target_group_port` | Port for the target group | `number` | `80` | no |
| `target_group_protocol` | Protocol for the target group | `string` | `"HTTP"` | no |
| `target_group_target_type` | Target type for the target group | `string` | `"instance"` | no |
| `target_group_description` | Description of the target group | `string` | `null` | no |

### Health Check Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `health_check_enabled` | Enable health checks | `bool` | `true` | no |
| `health_check_healthy_threshold` | Healthy threshold for health checks | `number` | `2` | no |
| `health_check_interval` | Interval for health checks in seconds | `number` | `30` | no |
| `health_check_matcher` | HTTP codes for successful health checks | `string` | `"200"` | no |
| `health_check_path` | Path for health checks | `string` | `"/"` | no |
| `health_check_port` | Port for health checks | `string` | `"80"` | no |
| `health_check_protocol` | Protocol for health checks | `string` | `"HTTP"` | no |
| `health_check_timeout` | Timeout for health checks in seconds | `number` | `5` | no |
| `health_check_unhealthy_threshold` | Unhealthy threshold for health checks | `number` | `3` | no |

### Listener Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `listener_port` | Port for the listener | `number` | `80` | no |
| `listener_protocol` | Protocol for the listener | `string` | `"HTTP"` | no |
| `listener_default_action_type` | Default action type for the listener | `string` | `"forward"` | no |

### Security Group Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `security_group_name` | Name of the security group | `string` | `null` | yes |
| `security_group_description` | Description of the security group | `string` | `null` | yes |
| `security_group_rules` | List of security group rules | `list(object)` | `[]` | no |

### Tagging Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `common_tags` | Common tags to apply to all resources | `map(string)` | `{}` | no |

## 📤 Outputs

### Load Balancer Outputs

| Name | Description |
|------|-------------|
| `load_balancer_id` | ID of the created load balancer |
| `load_balancer_arn` | ARN of the created load balancer |
| `load_balancer_name` | Name of the created load balancer |
| `load_balancer_dns_name` | DNS name of the created load balancer |
| `load_balancer_zone_id` | Zone ID of the created load balancer |

### Target Group Outputs

| Name | Description |
|------|-------------|
| `target_group_arn` | ARN of the created target group |
| `target_group_name` | Name of the created target group |
| `target_group_id` | ID of the created target group |

### Listener Outputs

| Name | Description |
|------|-------------|
| `listener_arn` | ARN of the created listener |
| `listener_id` | ID of the created listener |

### Security Group Outputs

| Name | Description |
|------|-------------|
| `security_group_id` | ID of the created security group |
| `security_group_arn` | ARN of the created security group |
| `security_group_name` | Name of the created security group |

## 🔧 Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## 🔗 Related Modules

- [terraform-aws-ec2-instance](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance) - EC2 instance module
- [terraform-ec2-wrapper](../terraform-ec2-wrapper) - Wrapper module that uses this load balancer module

## 📝 Notes

- Application Load Balancers are region-specific resources
- Target groups can be shared across multiple load balancers
- Health checks are essential for proper load balancing
- Internal load balancers are not accessible from the internet
- Security group rules should be configured based on your security requirements

## 🚨 Important

- Ensure the subnet ID is valid and exists
- Configure appropriate security group rules for your use case
- Health check paths should return HTTP 200 for successful checks
- Consider using HTTPS listeners with SSL certificates for production
- Load balancers cannot be deleted if they have active listeners
