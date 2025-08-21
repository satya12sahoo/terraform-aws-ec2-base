# CloudWatch Module

This module provides CloudWatch log groups and EventBridge scheduling capabilities for EC2 instances, enabling centralized logging and automated instance management.

## 🚀 Features

- **Log Group Management**: Create CloudWatch log groups with configurable retention
- **EventBridge Scheduling**: Automated instance start/stop scheduling
- **IAM Integration**: Automatic IAM role and policy creation for EventBridge
- **KMS Encryption**: Support for encrypted log groups
- **Flexible Scheduling**: Customizable cron expressions and timezones
- **Tag Management**: Comprehensive tagging support
- **Conditional Creation**: Toggle features on/off as needed

## 📖 Usage

### Basic Log Group Example

```hcl
module "cloudwatch_logs" {
  source = "../cloudwatch"

  # Log group configuration
  create_log_group = true
  log_group_name = "my-app-logs"
  log_retention_days = 30
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### Instance Scheduling Example

```hcl
module "cloudwatch_scheduling" {
  source = "../cloudwatch"

  # Instance information
  instance_name = "web-server"
  
  # Scheduling configuration
  enable_scheduling = true
  schedule_rule_name = "web-server-schedule"
  schedule_expression = "cron(0 8 * * 1-5)"  # Start at 8 AM on weekdays
  schedule_description = "Start web server on weekdays"
  schedule_timezone = "America/New_York"
  
  # IAM configuration
  eventbridge_role_name = "eventbridge-ec2-role"
  eventbridge_role_description = "Role for EventBridge to manage EC2 instances"
  eventbridge_policy_name = "eventbridge-ec2-policy"
  eventbridge_policy_description = "Policy for EventBridge EC2 management"
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "web-application"
  }
}
```

### Advanced Example with Both Features

```hcl
module "cloudwatch_complete" {
  source = "../cloudwatch"

  # Instance information
  instance_name = "database-server"
  
  # Log group configuration
  create_log_group = true
  log_group_name = "database-logs"
  log_retention_days = 90
  log_group_kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/database-logs-key"
  log_group_skip_destroy = false
  
  # Scheduling configuration
  enable_scheduling = true
  schedule_rule_name = "database-server-schedule"
  schedule_expression = "cron(0 6 * * 1-5)"  # Start at 6 AM on weekdays
  schedule_description = "Start database server on weekdays"
  schedule_timezone = "America/New_York"
  schedule_target_arn = "arn:aws:automate:us-east-1:ec2:start"
  
  # IAM configuration
  eventbridge_role_name = "eventbridge-database-role"
  eventbridge_role_description = "Role for EventBridge to manage database instances"
  eventbridge_policy_name = "eventbridge-database-policy"
  eventbridge_policy_description = "Policy for EventBridge database management"
  
  # Comprehensive tagging
  common_tags = {
    Environment = "production"
    Project     = "database-system"
    ManagedBy   = "terraform"
    BackupRequired = "true"
  }
}
```

## 📋 Inputs

### Log Group Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_log_group` | Whether to create a CloudWatch log group | `bool` | `false` | no |
| `log_group_name` | Name of the CloudWatch log group | `string` | `null` | yes |
| `log_retention_days` | Number of days to retain log events | `number` | `30` | no |
| `log_group_kms_key_id` | KMS key ID for log group encryption | `string` | `null` | no |
| `log_group_skip_destroy` | Whether to skip destroying log group on destroy | `bool` | `false` | no |

### Scheduling Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `enable_scheduling` | Whether to enable EventBridge scheduling | `bool` | `false` | no |
| `instance_name` | Name of the instance for scheduling | `string` | `null` | yes |
| `schedule_rule_name` | Name of the EventBridge rule | `string` | `null` | yes |
| `schedule_expression` | Cron expression for scheduling | `string` | `null` | yes |
| `schedule_description` | Description of the schedule rule | `string` | `null` | no |
| `schedule_timezone` | Timezone for the schedule | `string` | `"UTC"` | no |
| `schedule_target_arn` | ARN of the target for the schedule | `string` | `null` | no |

### IAM Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `eventbridge_role_name` | Name of the EventBridge IAM role | `string` | `null` | yes |
| `eventbridge_role_description` | Description of the EventBridge role | `string` | `null` | no |
| `eventbridge_policy_name` | Name of the EventBridge IAM policy | `string` | `null` | yes |
| `eventbridge_policy_description` | Description of the EventBridge policy | `string` | `null` | no |

### General Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `common_tags` | Common tags to apply to all resources | `map(string)` | `{}` | no |

## 📤 Outputs

### Log Group Outputs

| Name | Description |
|------|-------------|
| `log_group_arn` | ARN of the CloudWatch log group |
| `log_group_name` | Name of the CloudWatch log group |
| `log_group_id` | ID of the CloudWatch log group |

### Scheduling Outputs

| Name | Description |
|------|-------------|
| `schedule_rule_arn` | ARN of the EventBridge rule |
| `schedule_rule_name` | Name of the EventBridge rule |
| `schedule_target_id` | ID of the EventBridge target |
| `eventbridge_role_arn` | ARN of the EventBridge IAM role |
| `eventbridge_role_name` | Name of the EventBridge IAM role |
| `eventbridge_policy_arn` | ARN of the EventBridge IAM policy |
| `eventbridge_policy_name` | Name of the EventBridge IAM policy |

## 🔧 Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## 🔗 Related Modules

- [terraform-aws-ec2-instance](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance) - EC2 instance module
- [terraform-ec2-wrapper](../terraform-ec2-wrapper) - Wrapper module that uses this CloudWatch module

## 📝 Notes

- Log groups are created with configurable retention periods
- EventBridge scheduling requires appropriate IAM permissions
- KMS encryption is optional but recommended for sensitive logs
- Scheduling expressions use cron syntax
- All resources are tagged for better organization

## 🚨 Important

- Ensure the instance name matches the actual EC2 instance name for scheduling
- Verify that the KMS key exists and is accessible if using encryption
- EventBridge rules are region-specific
- Consider timezone differences when setting up schedules
- Log groups cannot be deleted if they contain log streams with data
