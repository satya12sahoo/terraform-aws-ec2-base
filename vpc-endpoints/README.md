# VPC Endpoints Module

This module creates VPC endpoints for AWS services with dedicated security groups, enabling private communication between your VPC and AWS services without requiring internet gateways or NAT gateways.

## 🚀 Features

- **VPC Endpoint Creation**: Create VPC endpoints for various AWS services
- **Security Group Management**: Dedicated security groups for endpoint access control
- **Private DNS**: Enable/disable private DNS for endpoints
- **Endpoint Policies**: Custom IAM policies for endpoint access control
- **Multiple Endpoint Types**: Support for Gateway and Interface endpoints
- **Subnet Integration**: Automatic subnet and VPC detection
- **Tag Management**: Comprehensive tagging support
- **Conditional Creation**: Toggle endpoint creation on/off

## 📖 Usage

### Basic Example

```hcl
module "vpc_endpoint" {
  source = "../vpc-endpoints"

  # Enable VPC endpoint creation
  create_vpc_endpoint = true
  
  # Basic configuration
  endpoint_name = "s3-endpoint"
  endpoint_description = "VPC endpoint for S3"
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  subnet_id = "subnet-12345678"
  
  # Security group configuration
  security_group_name = "s3-endpoint-sg"
  security_group_description = "Security group for S3 VPC endpoint"
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### Interface Endpoint Example

```hcl
module "vpc_endpoint" {
  source = "../vpc-endpoints"

  create_vpc_endpoint = true
  
  # Interface endpoint configuration
  endpoint_name = "ec2-endpoint"
  endpoint_description = "VPC endpoint for EC2 API"
  service_name = "com.amazonaws.us-east-1.ec2"
  vpc_endpoint_type = "Interface"
  subnet_id = "subnet-private-12345678"
  private_dns_enabled = true
  
  # Security group configuration
  security_group_name = "ec2-endpoint-sg"
  security_group_description = "Security group for EC2 VPC endpoint"
  security_group_rules = [
    {
      type = "ingress"
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
      description = "HTTPS from VPC"
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
    Project     = "private-network"
  }
}
```

### Advanced Example with Policy

```hcl
module "vpc_endpoint" {
  source = "../vpc-endpoints"

  create_vpc_endpoint = true
  
  # Endpoint configuration
  endpoint_name = "ssm-endpoint"
  endpoint_description = "VPC endpoint for Systems Manager"
  service_name = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type = "Interface"
  subnet_id = "subnet-private-12345678"
  private_dns_enabled = true
  
  # Endpoint policy
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:SourceVpc" = "vpc-12345678"
          }
        }
      }
    ]
  })
  
  # Security group configuration
  security_group_name = "ssm-endpoint-sg"
  security_group_description = "Security group for SSM VPC endpoint"
  security_group_rules = [
    {
      type = "ingress"
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
      description = "HTTPS from VPC"
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
    Project     = "systems-management"
    SecurityLevel = "high"
  }
}
```

### Multiple Endpoints Example

```hcl
# S3 Gateway Endpoint
module "s3_endpoint" {
  source = "../vpc-endpoints"

  create_vpc_endpoint = true
  
  endpoint_name = "s3-gateway-endpoint"
  endpoint_description = "Gateway endpoint for S3"
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  subnet_id = "subnet-private-12345678"
  
  security_group_name = "s3-endpoint-sg"
  security_group_description = "Security group for S3 gateway endpoint"
  
  common_tags = {
    Environment = "production"
    Project     = "storage"
    EndpointType = "gateway"
  }
}

# DynamoDB Gateway Endpoint
module "dynamodb_endpoint" {
  source = "../vpc-endpoints"

  create_vpc_endpoint = true
  
  endpoint_name = "dynamodb-gateway-endpoint"
  endpoint_description = "Gateway endpoint for DynamoDB"
  service_name = "com.amazonaws.us-east-1.dynamodb"
  vpc_endpoint_type = "Gateway"
  subnet_id = "subnet-private-12345678"
  
  security_group_name = "dynamodb-endpoint-sg"
  security_group_description = "Security group for DynamoDB gateway endpoint"
  
  common_tags = {
    Environment = "production"
    Project     = "database"
    EndpointType = "gateway"
  }
}

# Lambda Interface Endpoint
module "lambda_endpoint" {
  source = "../vpc-endpoints"

  create_vpc_endpoint = true
  
  endpoint_name = "lambda-interface-endpoint"
  endpoint_description = "Interface endpoint for Lambda"
  service_name = "com.amazonaws.us-east-1.lambda"
  vpc_endpoint_type = "Interface"
  subnet_id = "subnet-private-12345678"
  private_dns_enabled = true
  
  security_group_name = "lambda-endpoint-sg"
  security_group_description = "Security group for Lambda interface endpoint"
  security_group_rules = [
    {
      type = "ingress"
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
      description = "HTTPS from VPC"
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
  
  common_tags = {
    Environment = "production"
    Project     = "serverless"
    EndpointType = "interface"
  }
}
```

## 📋 Inputs

### VPC Endpoint Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_vpc_endpoint` | Whether to create a VPC endpoint | `bool` | `false` | no |
| `endpoint_name` | Name of the VPC endpoint | `string` | `null` | yes |
| `endpoint_description` | Description of the VPC endpoint | `string` | `null` | no |
| `service_name` | AWS service name for the endpoint | `string` | `null` | yes |
| `vpc_endpoint_type` | Type of VPC endpoint (Gateway or Interface) | `string` | `"Interface"` | no |
| `subnet_id` | Subnet ID for the endpoint | `string` | `null` | yes |
| `private_dns_enabled` | Enable private DNS for the endpoint | `bool` | `true` | no |
| `policy` | IAM policy for the endpoint | `string` | `null` | no |

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

### VPC Endpoint Outputs

| Name | Description |
|------|-------------|
| `vpc_endpoint_id` | ID of the created VPC endpoint |
| `vpc_endpoint_arn` | ARN of the created VPC endpoint |
| `vpc_endpoint_dns_entries` | DNS entries for the VPC endpoint |
| `vpc_endpoint_network_interface_ids` | Network interface IDs for the VPC endpoint |
| `vpc_endpoint_owner_id` | Owner ID of the VPC endpoint |
| `vpc_endpoint_state` | State of the VPC endpoint |

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
- [terraform-ec2-wrapper](../terraform-ec2-wrapper) - Wrapper module that uses this VPC endpoints module

## 📝 Notes

- VPC endpoints are region-specific resources
- Gateway endpoints are free and support S3 and DynamoDB
- Interface endpoints incur charges and support most AWS services
- Private DNS must be enabled for interface endpoints to work properly
- Security groups are only required for interface endpoints

## 🚨 Important

- Ensure the subnet ID is valid and exists
- Gateway endpoints don't require security groups
- Interface endpoints require security groups with appropriate rules
- Service names must be in the correct format (e.g., com.amazonaws.region.service)
- VPC endpoints cannot be deleted if they are in use by other resources
