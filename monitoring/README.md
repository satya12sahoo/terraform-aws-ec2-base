# Monitoring Module

This module creates comprehensive CloudWatch monitoring for EC2 instances, including CPU, memory, disk, network, and status check alarms, along with customizable CloudWatch dashboards for centralized monitoring.

## 🚀 Features

- **CPU Monitoring**: Configurable CPU utilization alarms
- **Memory Monitoring**: Memory utilization alarms (requires CloudWatch agent)
- **Disk Monitoring**: Disk utilization alarms (requires CloudWatch agent)
- **Network Monitoring**: Network in/out alarms
- **Status Check Monitoring**: Instance and system status check alarms
- **CloudWatch Dashboard**: Centralized monitoring dashboard
- **SNS Integration**: Alarm actions for notifications
- **Customizable Thresholds**: Flexible alarm thresholds and evaluation periods
- **Tag Management**: Comprehensive tagging support
- **Conditional Creation**: Toggle monitoring features on/off

## 📖 Usage

### Basic Example

```hcl
module "monitoring" {
  source = "../monitoring"

  # Instance information
  instance_id = "i-1234567890abcdef0"
  instance_name = "web-server"
  
  # Enable basic monitoring
  create_cpu_alarm = true
  create_status_check_alarm = true
  create_dashboard = true
  
  # Tags
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### Advanced Example with All Alarms

```hcl
module "monitoring" {
  source = "../monitoring"

  # Instance information
  instance_id = "i-1234567890abcdef0"
  instance_name = "app-server"
  
  # CPU monitoring
  create_cpu_alarm = true
  cpu_threshold = 80
  cpu_evaluation_periods = 2
  cpu_period = 300
  cpu_alarm_actions = [aws_sns_topic.alerts.arn]
  
  # Memory monitoring (requires CloudWatch agent)
  create_memory_alarm = true
  memory_threshold = 85
  memory_evaluation_periods = 2
  memory_period = 300
  memory_alarm_actions = [aws_sns_topic.alerts.arn]
  
  # Disk monitoring (requires CloudWatch agent)
  create_disk_alarm = true
  disk_threshold = 90
  disk_evaluation_periods = 2
  disk_period = 300
  disk_alarm_actions = [aws_sns_topic.alerts.arn]
  
  # Network monitoring
  create_network_in_alarm = true
  network_in_threshold = 1000000  # 1 MB/s
  network_in_evaluation_periods = 2
  network_in_period = 300
  network_in_alarm_actions = [aws_sns_topic.alerts.arn]
  
  create_network_out_alarm = true
  network_out_threshold = 500000  # 500 KB/s
  network_out_evaluation_periods = 2
  network_out_period = 300
  network_out_alarm_actions = [aws_sns_topic.alerts.arn]
  
  # Status check monitoring
  create_status_check_alarm = true
  status_check_evaluation_periods = 2
  status_check_period = 60
  status_check_alarm_actions = [aws_sns_topic.alerts.arn]
  
  # Dashboard configuration
  create_dashboard = true
  dashboard_name = "app-server-dashboard"
  dashboard_period = 300
  
  # Tags
  tags = {
    Environment = "production"
    Project     = "web-application"
    MonitoringLevel = "comprehensive"
  }
}
```

### Production Example with SNS Integration

```hcl
# SNS Topic for alerts
resource "aws_sns_topic" "alerts" {
  name = "ec2-monitoring-alerts"
  tags = {
    Environment = "production"
    Purpose     = "EC2 Monitoring Alerts"
  }
}

# SNS Topic Subscription
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "admin@example.com"
}

module "monitoring" {
  source = "../monitoring"

  # Instance information
  instance_id = "i-1234567890abcdef0"
  instance_name = "database-server"
  
  # Critical monitoring for database
  create_cpu_alarm = true
  cpu_threshold = 70  # Lower threshold for database
  cpu_evaluation_periods = 3
  cpu_period = 300
  cpu_alarm_actions = [aws_sns_topic.alerts.arn]
  
  create_memory_alarm = true
  memory_threshold = 80  # Lower threshold for database
  memory_evaluation_periods = 3
  memory_period = 300
  memory_alarm_actions = [aws_sns_topic.alerts.arn]
  
  create_disk_alarm = true
  disk_threshold = 85  # Lower threshold for database
  disk_evaluation_periods = 3
  disk_period = 300
  disk_alarm_actions = [aws_sns_topic.alerts.arn]
  
  create_status_check_alarm = true
  status_check_evaluation_periods = 2
  status_check_period = 60
  status_check_alarm_actions = [aws_sns_topic.alerts.arn]
  
  # Dashboard
  create_dashboard = true
  dashboard_name = "database-server-dashboard"
  dashboard_period = 300
  
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
  name = "ec2-monitoring-alerts"
}

# Monitoring for web servers
module "web_monitoring" {
  source = "../monitoring"
  for_each = {
    web-1 = "i-1234567890abcdef0"
    web-2 = "i-0987654321fedcba0"
  }

  instance_id = each.value
  instance_name = each.key
  
  # Web server monitoring
  create_cpu_alarm = true
  cpu_threshold = 80
  cpu_alarm_actions = [aws_sns_topic.alerts.arn]
  
  create_status_check_alarm = true
  status_check_alarm_actions = [aws_sns_topic.alerts.arn]
  
  create_dashboard = true
  dashboard_name = "${each.key}-dashboard"
  
  tags = {
    Environment = "production"
    Project     = "web-application"
    ServerType  = "web"
  }
}

# Monitoring for app servers
module "app_monitoring" {
  source = "../monitoring"
  for_each = {
    app-1 = "i-abcdef1234567890"
    app-2 = "i-fedcba0987654321"
  }

  instance_id = each.value
  instance_name = each.key
  
  # App server monitoring
  create_cpu_alarm = true
  cpu_threshold = 75
  cpu_alarm_actions = [aws_sns_topic.alerts.arn]
  
  create_memory_alarm = true
  memory_threshold = 85
  memory_alarm_actions = [aws_sns_topic.alerts.arn]
  
  create_status_check_alarm = true
  status_check_alarm_actions = [aws_sns_topic.alerts.arn]
  
  create_dashboard = true
  dashboard_name = "${each.key}-dashboard"
  
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
| `instance_id` | ID of the EC2 instance to monitor | `string` | `null` | yes |
| `instance_name` | Name of the EC2 instance for naming resources | `string` | `null` | yes |

### CPU Monitoring Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_cpu_alarm` | Whether to create CPU utilization alarm | `bool` | `true` | no |
| `cpu_threshold` | CPU utilization threshold percentage | `number` | `80` | no |
| `cpu_evaluation_periods` | Number of evaluation periods for CPU alarm | `number` | `2` | no |
| `cpu_period` | Period in seconds for CPU alarm | `number` | `300` | no |
| `cpu_alarm_actions` | Actions to take when CPU alarm triggers | `list(string)` | `[]` | no |

### Memory Monitoring Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_memory_alarm` | Whether to create memory utilization alarm | `bool` | `false` | no |
| `memory_threshold` | Memory utilization threshold percentage | `number` | `85` | no |
| `memory_evaluation_periods` | Number of evaluation periods for memory alarm | `number` | `2` | no |
| `memory_period` | Period in seconds for memory alarm | `number` | `300` | no |
| `memory_alarm_actions` | Actions to take when memory alarm triggers | `list(string)` | `[]` | no |

### Disk Monitoring Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_disk_alarm` | Whether to create disk utilization alarm | `bool` | `false` | no |
| `disk_threshold` | Disk utilization threshold percentage | `number` | `85` | no |
| `disk_evaluation_periods` | Number of evaluation periods for disk alarm | `number` | `2` | no |
| `disk_period` | Period in seconds for disk alarm | `number` | `300` | no |
| `disk_alarm_actions` | Actions to take when disk alarm triggers | `list(string)` | `[]` | no |

### Network Monitoring Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_network_in_alarm` | Whether to create network in alarm | `bool` | `false` | no |
| `network_in_threshold` | Network in threshold in bytes | `number` | `1000000` | no |
| `network_in_evaluation_periods` | Number of evaluation periods for network in alarm | `number` | `2` | no |
| `network_in_period` | Period in seconds for network in alarm | `number` | `300` | no |
| `network_in_alarm_actions` | Actions to take when network in alarm triggers | `list(string)` | `[]` | no |
| `create_network_out_alarm` | Whether to create network out alarm | `bool` | `false` | no |
| `network_out_threshold` | Network out threshold in bytes | `number` | `500000` | no |
| `network_out_evaluation_periods` | Number of evaluation periods for network out alarm | `number` | `2` | no |
| `network_out_period` | Period in seconds for network out alarm | `number` | `300` | no |
| `network_out_alarm_actions` | Actions to take when network out alarm triggers | `list(string)` | `[]` | no |

### Status Check Monitoring Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_status_check_alarm` | Whether to create status check alarm | `bool` | `true` | no |
| `status_check_evaluation_periods` | Number of evaluation periods for status check alarm | `number` | `2` | no |
| `status_check_period` | Period in seconds for status check alarm | `number` | `60` | no |
| `status_check_alarm_actions` | Actions to take when status check alarm triggers | `list(string)` | `[]` | no |

### Dashboard Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_dashboard` | Whether to create CloudWatch dashboard | `bool` | `true` | no |
| `dashboard_name` | Name for the CloudWatch dashboard | `string` | `null` | no |
| `dashboard_period` | Period in seconds for dashboard metrics | `number` | `300` | no |

### Tagging Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `tags` | Tags to apply to all monitoring resources | `map(string)` | `{}` | no |

## 📤 Outputs

### Alarm Outputs

| Name | Description |
|------|-------------|
| `cpu_alarm_arn` | ARN of the CPU utilization alarm |
| `cpu_alarm_name` | Name of the CPU utilization alarm |
| `memory_alarm_arn` | ARN of the memory utilization alarm |
| `memory_alarm_name` | Name of the memory utilization alarm |
| `disk_alarm_arn` | ARN of the disk utilization alarm |
| `disk_alarm_name` | Name of the disk utilization alarm |
| `network_in_alarm_arn` | ARN of the network in alarm |
| `network_in_alarm_name` | Name of the network in alarm |
| `network_out_alarm_arn` | ARN of the network out alarm |
| `network_out_alarm_name` | Name of the network out alarm |
| `status_check_alarm_arn` | ARN of the status check alarm |
| `status_check_alarm_name` | Name of the status check alarm |

### Dashboard Outputs

| Name | Description |
|------|-------------|
| `dashboard_arn` | ARN of the CloudWatch dashboard |
| `dashboard_name` | Name of the CloudWatch dashboard |

### Summary Outputs

| Name | Description |
|------|-------------|
| `all_alarms` | Map of all created alarms |
| `all_alarm_arns` | Map of all alarm ARNs |
| `all_alarm_names` | Map of all alarm names |
| `monitoring_summary` | Summary of all monitoring resources |

## 🔧 Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## 🔗 Related Modules

- [terraform-aws-ec2-instance](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance) - EC2 instance module
- [terraform-ec2-wrapper](../terraform-ec2-wrapper) - Wrapper module that uses this monitoring module

## 📝 Notes

- Memory and disk monitoring require CloudWatch agent to be installed on instances
- CPU and network monitoring use AWS-provided metrics
- Status check alarms monitor both instance and system status
- Dashboards provide centralized view of all instance metrics
- SNS integration enables email, SMS, or other notification methods

## 🚨 Important

- Ensure the instance ID is valid and exists
- Configure appropriate alarm thresholds for your workload
- Memory and disk alarms require CloudWatch agent installation
- Consider using SNS topics for alarm notifications
- Monitor alarm costs as they can accumulate with many instances
