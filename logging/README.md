# Logging Module

This module creates comprehensive CloudWatch logging infrastructure for EC2 instances, including log groups, log streams, metric filters, and log-based alarms for centralized log management and monitoring.

## 🚀 Features

- **Log Group Management**: Create CloudWatch log groups with configurable retention
- **Log Stream Creation**: Automatic log stream creation for structured logging
- **Metric Filters**: Create metric filters for log pattern detection
- **Log-Based Alarms**: CloudWatch alarms based on log metrics
- **Multiple Log Types**: Support for application, system, access, and error logs
- **Custom Log Groups**: Flexible custom log group configuration
- **KMS Encryption**: Support for encrypted log groups
- **Retention Management**: Configurable log retention periods
- **Tag Management**: Comprehensive tagging support
- **Conditional Creation**: Toggle logging features on/off

## 📖 Usage

### Basic Example

```hcl
module "logging" {
  source = "../logging"

  # Instance information
  instance_name = "web-server"
  
  # Enable basic logging
  create_application_log_group = true
  create_system_log_group = true
  create_error_log_group = true
  
  # Tags
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### Advanced Example with All Features

```hcl
module "logging" {
  source = "../logging"

  # Instance information
  instance_name = "app-server"
  
  # Application log group
  create_application_log_group = true
  application_log_group_name = "app-server-application-logs"
  application_log_retention_days = 30
  create_application_log_stream = true
  application_log_stream_name = "app-server-app-stream"
  
  # System log group
  create_system_log_group = true
  system_log_group_name = "app-server-system-logs"
  system_log_retention_days = 30
  create_system_log_stream = true
  system_log_stream_name = "app-server-system-stream"
  
  # Access log group
  create_access_log_group = true
  access_log_group_name = "app-server-access-logs"
  access_log_retention_days = 30
  create_access_log_stream = true
  access_log_stream_name = "app-server-access-stream"
  
  # Error log group
  create_error_log_group = true
  error_log_group_name = "app-server-error-logs"
  error_log_retention_days = 90
  create_error_log_stream = true
  error_log_stream_name = "app-server-error-stream"
  
  # Metric filters
  create_error_metric_filter = true
  error_metric_filter_pattern = "[timestamp, level=ERROR, message]"
  error_metric_namespace = "EC2/Logs"
  
  create_access_metric_filter = true
  access_metric_filter_pattern = "[timestamp, ip, method, path, status]"
  access_metric_namespace = "EC2/Logs"
  
  # Log alarms
  create_error_log_alarm = true
  error_log_alarm_threshold = 5
  error_log_alarm_actions = [aws_sns_topic.alerts.arn]
  
  create_access_log_alarm = true
  access_log_alarm_threshold = 1000
  access_log_alarm_actions = [aws_sns_topic.alerts.arn]
  
  # Tags
  tags = {
    Environment = "production"
    Project     = "web-application"
    LoggingLevel = "comprehensive"
  }
}
```

### Production Example with Custom Log Groups

```hcl
# SNS Topic for alerts
resource "aws_sns_topic" "alerts" {
  name = "ec2-logging-alerts"
  tags = {
    Environment = "production"
    Purpose     = "EC2 Logging Alerts"
  }
}

# SNS Topic Subscription
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "admin@example.com"
}

module "logging" {
  source = "../logging"

  # Instance information
  instance_name = "database-server"
  
  # Standard log groups
  create_application_log_group = true
  application_log_retention_days = 60
  create_application_log_stream = true
  
  create_system_log_group = true
  system_log_retention_days = 60
  create_system_log_stream = true
  
  create_error_log_group = true
  error_log_retention_days = 120
  create_error_log_stream = true
  
  # Custom log groups
  custom_log_groups = {
    database = {
      retention_days = 90
      tags = {
        LogType = "database"
        Environment = "production"
      }
    }
    api = {
      retention_days = 45
      tags = {
        LogType = "api"
        Environment = "production"
      }
    }
    security = {
      retention_days = 180
      tags = {
        LogType = "security"
        Environment = "production"
      }
    }
  }
  
  # Custom log streams
  custom_log_streams = {
    database_stream = {
      log_group_key = "database"
    }
    api_stream = {
      log_group_key = "api"
    }
    security_stream = {
      log_group_key = "security"
    }
  }
  
  # Custom metric filters
  custom_metric_filters = {
    database_errors = {
      pattern = "[timestamp, level=ERROR, database=*, message]"
      log_group_key = "database"
      metric_name = "database-error-count"
      metric_namespace = "EC2/Database"
    }
    api_errors = {
      pattern = "[timestamp, level=ERROR, api=*, message]"
      log_group_key = "api"
      metric_name = "api-error-count"
      metric_namespace = "EC2/API"
    }
    security_events = {
      pattern = "[timestamp, level=WARN, security=*, event]"
      log_group_key = "security"
      metric_name = "security-event-count"
      metric_namespace = "EC2/Security"
    }
  }
  
  # Custom log alarms
  custom_log_alarms = {
    database_errors = {
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods = 2
      period = 300
      statistic = "Sum"
      threshold = 3
      alarm_description = "Database error rate alarm"
      alarm_actions = [aws_sns_topic.alerts.arn]
      metric_name = "database-error-count"
      metric_namespace = "EC2/Database"
    }
    api_errors = {
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods = 2
      period = 300
      statistic = "Sum"
      threshold = 5
      alarm_description = "API error rate alarm"
      alarm_actions = [aws_sns_topic.alerts.arn]
      metric_name = "api-error-count"
      metric_namespace = "EC2/API"
    }
    security_events = {
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods = 1
      period = 300
      statistic = "Sum"
      threshold = 1
      alarm_description = "Security event alarm"
      alarm_actions = [aws_sns_topic.alerts.arn]
      metric_name = "security-event-count"
      metric_namespace = "EC2/Security"
    }
  }
  
  # Tags
  tags = {
    Environment = "production"
    Project     = "database-system"
    Criticality = "high"
  }
}
```

### Multiple Instances Example

```hcl
# SNS Topic for alerts
resource "aws_sns_topic" "alerts" {
  name = "ec2-logging-alerts"
}

# Logging for web servers
module "web_logging" {
  source = "../logging"
  for_each = {
    web-1 = "web-server-1"
    web-2 = "web-server-2"
  }

  instance_name = each.value
  
  # Web server logging
  create_application_log_group = true
  application_log_retention_days = 30
  create_application_log_stream = true
  
  create_access_log_group = true
  access_log_retention_days = 30
  create_access_log_stream = true
  
  create_error_log_group = true
  error_log_retention_days = 60
  create_error_log_stream = true
  
  # Error monitoring
  create_error_metric_filter = true
  create_error_log_alarm = true
  error_log_alarm_threshold = 3
  error_log_alarm_actions = [aws_sns_topic.alerts.arn]
  
  tags = {
    Environment = "production"
    Project     = "web-application"
    ServerType  = "web"
  }
}

# Logging for app servers
module "app_logging" {
  source = "../logging"
  for_each = {
    app-1 = "app-server-1"
    app-2 = "app-server-2"
  }

  instance_name = each.value
  
  # App server logging
  create_application_log_group = true
  application_log_retention_days = 45
  create_application_log_stream = true
  
  create_system_log_group = true
  system_log_retention_days = 45
  create_system_log_stream = true
  
  create_error_log_group = true
  error_log_retention_days = 90
  create_error_log_stream = true
  
  # Custom log groups for app servers
  custom_log_groups = {
    business_logic = {
      retention_days = 60
      tags = {
        LogType = "business_logic"
        ServerType = "app"
      }
    }
  }
  
  custom_log_streams = {
    business_logic_stream = {
      log_group_key = "business_logic"
    }
  }
  
  # Error monitoring
  create_error_metric_filter = true
  create_error_log_alarm = true
  error_log_alarm_threshold = 5
  error_log_alarm_actions = [aws_sns_topic.alerts.arn]
  
  tags = {
    Environment = "production"
    Project     = "web-application"
    ServerType  = "app"
  }
}
```

## 📋 Inputs

### Instance Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `instance_name` | Name of the EC2 instance for log group and stream naming | `string` | `null` | yes |
| `tags` | Tags to apply to all logging resources | `map(string)` | `{}` | no |

### Application Log Group Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_application_log_group` | Whether to create a CloudWatch log group for application logs | `bool` | `false` | no |
| `application_log_group_name` | Name for the application log group | `string` | `null` | no |
| `application_log_retention_days` | Retention days for application logs | `number` | `30` | no |
| `application_log_group_kms_key_id` | KMS key ID for application log group encryption | `string` | `null` | no |
| `application_log_group_skip_destroy` | Whether to skip destroying application log group | `bool` | `false` | no |

### System Log Group Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_system_log_group` | Whether to create a CloudWatch log group for system logs | `bool` | `false` | no |
| `system_log_group_name` | Name for the system log group | `string` | `null` | no |
| `system_log_retention_days` | Retention days for system logs | `number` | `30` | no |
| `system_log_group_kms_key_id` | KMS key ID for system log group encryption | `string` | `null` | no |
| `system_log_group_skip_destroy` | Whether to skip destroying system log group | `bool` | `false` | no |

### Access Log Group Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_access_log_group` | Whether to create a CloudWatch log group for access logs | `bool` | `false` | no |
| `access_log_group_name` | Name for the access log group | `string` | `null` | no |
| `access_log_retention_days` | Retention days for access logs | `number` | `30` | no |
| `access_log_group_kms_key_id` | KMS key ID for access log group encryption | `string` | `null` | no |
| `access_log_group_skip_destroy` | Whether to skip destroying access log group | `bool` | `false` | no |

### Error Log Group Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_error_log_group` | Whether to create a CloudWatch log group for error logs | `bool` | `false` | no |
| `error_log_group_name` | Name for the error log group | `string` | `null` | no |
| `error_log_retention_days` | Retention days for error logs | `number` | `90` | no |
| `error_log_group_kms_key_id` | KMS key ID for error log group encryption | `string` | `null` | no |
| `error_log_group_skip_destroy` | Whether to skip destroying error log group | `bool` | `false` | no |

### Log Stream Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_application_log_stream` | Whether to create application log stream | `bool` | `false` | no |
| `application_log_stream_name` | Name for the application log stream | `string` | `null` | no |
| `create_system_log_stream` | Whether to create system log stream | `bool` | `false` | no |
| `system_log_stream_name` | Name for the system log stream | `string` | `null` | no |
| `create_access_log_stream` | Whether to create access log stream | `bool` | `false` | no |
| `access_log_stream_name` | Name for the access log stream | `string` | `null` | no |
| `create_error_log_stream` | Whether to create error log stream | `bool` | `false` | no |
| `error_log_stream_name` | Name for the error log stream | `string` | `null` | no |

### Metric Filter Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_error_metric_filter` | Whether to create error metric filter | `bool` | `false` | no |
| `error_metric_filter_pattern` | Pattern for error metric filter | `string` | `"[timestamp, level=ERROR, message]"` | no |
| `error_metric_namespace` | Namespace for error metrics | `string` | `"EC2/Logs"` | no |
| `create_access_metric_filter` | Whether to create access metric filter | `bool` | `false` | no |
| `access_metric_filter_pattern` | Pattern for access metric filter | `string` | `"[timestamp, ip, method, path, status]"` | no |
| `access_metric_namespace` | Namespace for access metrics | `string` | `"EC2/Logs"` | no |

### Log Alarm Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_error_log_alarm` | Whether to create error log alarm | `bool` | `false` | no |
| `error_log_alarm_threshold` | Threshold for error log alarm | `number` | `10` | no |
| `error_log_alarm_actions` | Actions for error log alarm | `list(string)` | `[]` | no |
| `create_access_log_alarm` | Whether to create access log alarm | `bool` | `false` | no |
| `access_log_alarm_threshold` | Threshold for access log alarm | `number` | `1000` | no |
| `access_log_alarm_actions` | Actions for access log alarm | `list(string)` | `[]` | no |

### Custom Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `custom_log_groups` | Map of custom log groups | `map(object)` | `{}` | no |
| `custom_log_streams` | Map of custom log streams | `map(object)` | `{}` | no |
| `custom_metric_filters` | Map of custom metric filters | `map(object)` | `{}` | no |
| `custom_log_alarms` | Map of custom log alarms | `map(object)` | `{}` | no |

## 📤 Outputs

### Log Group Outputs

| Name | Description |
|------|-------------|
| `application_log_group` | Application log group resource |
| `application_log_group_name` | Name of the application log group |
| `application_log_group_arn` | ARN of the application log group |
| `system_log_group` | System log group resource |
| `system_log_group_name` | Name of the system log group |
| `system_log_group_arn` | ARN of the system log group |
| `access_log_group` | Access log group resource |
| `access_log_group_name` | Name of the access log group |
| `access_log_group_arn` | ARN of the access log group |
| `error_log_group` | Error log group resource |
| `error_log_group_name` | Name of the error log group |
| `error_log_group_arn` | ARN of the error log group |
| `custom_log_groups` | Map of custom log group resources |
| `custom_log_group_names` | Map of custom log group names |
| `custom_log_group_arns` | Map of custom log group ARNs |

### Log Stream Outputs

| Name | Description |
|------|-------------|
| `application_log_stream` | Application log stream resource |
| `application_log_stream_name` | Name of the application log stream |
| `system_log_stream` | System log stream resource |
| `system_log_stream_name` | Name of the system log stream |
| `access_log_stream` | Access log stream resource |
| `access_log_stream_name` | Name of the access log stream |
| `error_log_stream` | Error log stream resource |
| `error_log_stream_name` | Name of the error log stream |
| `custom_log_streams` | Map of custom log stream resources |
| `custom_log_stream_names` | Map of custom log stream names |

### Metric Filter Outputs

| Name | Description |
|------|-------------|
| `error_metric_filter` | Error metric filter resource |
| `error_metric_filter_name` | Name of the error metric filter |
| `access_metric_filter` | Access metric filter resource |
| `access_metric_filter_name` | Name of the access metric filter |
| `custom_metric_filters` | Map of custom metric filter resources |
| `custom_metric_filter_names` | Map of custom metric filter names |

### Log Alarm Outputs

| Name | Description |
|------|-------------|
| `error_log_alarm` | Error log alarm resource |
| `error_log_alarm_name` | Name of the error log alarm |
| `error_log_alarm_arn` | ARN of the error log alarm |
| `access_log_alarm` | Access log alarm resource |
| `access_log_alarm_name` | Name of the access log alarm |
| `access_log_alarm_arn` | ARN of the access log alarm |
| `custom_log_alarms` | Map of custom log alarm resources |
| `custom_log_alarm_names` | Map of custom log alarm names |
| `custom_log_alarm_arns` | Map of custom log alarm ARNs |

### Summary Outputs

| Name | Description |
|------|-------------|
| `all_log_groups` | Map of all log group resources |
| `all_log_group_names` | Map of all log group names |
| `all_log_group_arns` | Map of all log group ARNs |
| `all_log_streams` | Map of all log stream resources |
| `all_log_stream_names` | Map of all log stream names |
| `all_metric_filters` | Map of all metric filter resources |
| `all_metric_filter_names` | Map of all metric filter names |
| `all_log_alarms` | Map of all log alarm resources |
| `all_log_alarm_names` | Map of all log alarm names |
| `all_log_alarm_arns` | Map of all log alarm ARNs |
| `logging_summary` | Summary of all logging resources |

## 🔧 Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## 🔗 Related Modules

- [terraform-aws-ec2-instance](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance) - EC2 instance module
- [terraform-ec2-wrapper](../terraform-ec2-wrapper) - Wrapper module that uses this logging module

## 📝 Notes

- Log groups are created with configurable retention periods
- Log streams provide structured logging capabilities
- Metric filters enable log-based monitoring and alerting
- KMS encryption is optional but recommended for sensitive logs
- Custom log groups allow for application-specific logging needs

## 🚨 Important

- Ensure the instance name is unique and descriptive
- Configure appropriate retention periods for your compliance requirements
- KMS keys must exist and be accessible if using encryption
- Metric filter patterns must match your log format
- Consider log costs as they can accumulate with high-volume logging
