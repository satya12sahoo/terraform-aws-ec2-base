# IAM Instance Profile Module

This module creates IAM instance profiles for existing IAM roles, allowing EC2 instances to assume roles without creating new IAM roles from scratch.

## 🚀 Features

- **Instance Profile Creation**: Create instance profiles for existing IAM roles
- **Flexible Naming**: Customizable instance profile names and paths
- **Tag Management**: Comprehensive tagging support
- **Rotation Support**: Enable instance profile rotation
- **Permissions Boundary**: Support for permissions boundaries
- **Conditional Creation**: Toggle instance profile creation on/off

## 📖 Usage

### Basic Example

```hcl
module "iam_instance_profile" {
  source = "../iam"

  # Enable instance profile creation
  create_instance_profile = true
  
  # IAM role details
  iam_role_name = "existing-ec2-role"
  instance_profile_name = "ec2-instance-profile"
  
  # Optional configuration
  instance_profile_path = "/"
  instance_profile_description = "Instance profile for EC2 instances"
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "my-project"
  }
  
  instance_profile_tags = {
    Purpose = "EC2 instance profile"
  }
}
```

### Advanced Example

```hcl
module "iam_instance_profile" {
  source = "../iam"

  create_instance_profile = true
  
  # IAM role and profile configuration
  iam_role_name = "web-server-role"
  instance_profile_name = "web-server-instance-profile"
  instance_profile_path = "/ec2/"
  instance_profile_description = "Instance profile for web servers"
  
  # Advanced features
  enable_instance_profile_rotation = true
  instance_profile_permissions_boundary = "arn:aws:iam::123456789012:policy/PermissionsBoundary"
  
  # Comprehensive tagging
  common_tags = {
    Environment = "production"
    Project     = "web-application"
    ManagedBy   = "terraform"
  }
  
  instance_profile_tags = {
    Role        = "web-server"
    Component   = "frontend"
    SecurityLevel = "high"
  }
}
```

## 📋 Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_instance_profile` | Whether to create an instance profile | `bool` | `false` | no |
| `iam_role_name` | Name of the existing IAM role to attach to the instance profile | `string` | `null` | yes |
| `instance_profile_name` | Name for the instance profile | `string` | `null` | yes |
| `instance_profile_path` | Path for the instance profile | `string` | `"/"` | no |
| `instance_profile_description` | Description for the instance profile | `string` | `null` | no |
| `instance_profile_tags` | Additional tags for the instance profile | `map(string)` | `{}` | no |
| `enable_instance_profile_rotation` | Enable instance profile rotation | `bool` | `false` | no |
| `instance_profile_permissions_boundary` | Permissions boundary for the instance profile | `string` | `null` | no |
| `common_tags` | Common tags to apply to all resources | `map(string)` | `{}` | no |

## 📤 Outputs

| Name | Description |
|------|-------------|
| `instance_profile_id` | ID of the created instance profile |
| `instance_profile_arn` | ARN of the created instance profile |
| `instance_profile_name` | Name of the created instance profile |
| `instance_profile_path` | Path of the created instance profile |
| `instance_profile_unique_id` | Unique ID of the created instance profile |

## 🔧 Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## 🔗 Related Modules

- [terraform-aws-ec2-instance](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance) - EC2 instance module
- [terraform-ec2-wrapper](../terraform-ec2-wrapper) - Wrapper module that uses this IAM module

## 📝 Notes

- This module requires an existing IAM role to be created beforehand
- The IAM role must have the appropriate trust policy for EC2 instances
- Instance profiles are region-specific resources
- Tags are automatically merged with module-specific tags

## 🚨 Important

- Ensure the IAM role exists before creating the instance profile
- Verify that the IAM role has the necessary permissions for your use case
- Consider using permissions boundaries for enhanced security
- Instance profiles cannot be deleted if they are attached to running instances
