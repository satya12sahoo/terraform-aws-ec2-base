# Auto Scaling Module

This module creates Auto Scaling Groups (ASG) with scaling policies, CloudWatch alarms, and launch template integration for EC2 instances, providing automatic scaling capabilities based on metrics.

## 🚀 Features

- **Auto Scaling Group**: Create ASG with configurable capacity settings
- **Scaling Policies**: Automatic scale-in and scale-out policies
- **CloudWatch Alarms**: CPU-based scaling alarms with customizable thresholds
- **Launch Template Integration**: Support for launch templates and mixed instances
- **Instance Refresh**: Automatic instance refresh capabilities
- **Scale-in Protection**: Protect instances from scale-in operations
- **Suspended Processes**: Control ASG processes
- **Mixed Instances Policy**: Support for spot and on-demand instances
- **Tag Management**: Comprehensive tagging support
- **Conditional Creation**: Toggle ASG creation on/off

## 📖 Usage

### Basic Example

```hcl
module "autoscaling_group" {
  source = "../autoscaling"

  # Enable ASG creation
  create_auto_scaling_group = true
  
  # Basic configuration
  asg_name = "web-server-asg"
  asg_description = "Auto Scaling Group for web servers"
  subnet_id = "subnet-12345678"
  
  # Capacity configuration
  desired_capacity = 2
  min_size = 1
  max_size = 5
  
  # Launch template configuration
  launch_template_name = "web-server-template"
  launch_template_version = "$Latest"
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### Advanced Example with Scaling Policies

```hcl
module "autoscaling_group" {
  source = "../autoscaling"

  create_auto_scaling_group = true
  
  # ASG configuration
  asg_name = "app-server-asg"
  asg_description = "Auto Scaling Group for application servers"
  subnet_id = "subnet-12345678"
  
  # Capacity configuration
  desired_capacity = 3
  min_size = 2
  max_size = 10
  
  # Health check configuration
  health_check_type = "ELB"
  health_check_grace_period = 300
  cooldown = 300
  
  # Launch template configuration
  launch_template_name = "app-server-template"
  launch_template_version = "$Latest"
  
  # Scale-in protection
  enable_scale_in_protection = true
  
  # Instance refresh
  enable_instance_refresh = true
  instance_refresh_strategy = "Rolling"
  instance_refresh_min_healthy_percentage = 50
  
  # Suspended processes
  suspended_processes = ["ReplaceUnhealthy"]
  
  # Scaling policies
  scale_out_policy_name = "app-server-scale-out"
  scale_out_adjustment = 1
  scale_in_policy_name = "app-server-scale-in"
  scale_in_adjustment = -1
  
  # CloudWatch alarms
  scale_out_alarm_name = "app-server-cpu-high"
  scale_out_threshold = 80
  scale_out_alarm_description = "Scale out when CPU is high"
  scale_in_alarm_name = "app-server-cpu-low"
  scale_in_threshold = 30
  scale_in_alarm_description = "Scale in when CPU is low"
  
  # Alarm configuration
  alarm_evaluation_periods = 2
  alarm_metric_name = "CPUUtilization"
  alarm_namespace = "AWS/EC2"
  alarm_period = 300
  alarm_statistic = "Average"
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "web-application"
    AutoScaling = "enabled"
  }
}
```

### Mixed Instances Example

```hcl
module "autoscaling_group" {
  source = "../autoscaling"

  create_auto_scaling_group = true
  
  # ASG configuration
  asg_name = "cost-optimized-asg"
  asg_description = "Cost-optimized Auto Scaling Group with mixed instances"
  subnet_id = "subnet-12345678"
  
  # Capacity configuration
  desired_capacity = 2
  min_size = 1
  max_size = 8
  
  # Launch template configuration
  launch_template_name = "mixed-instance-template"
  launch_template_version = "$Latest"
  
  # Mixed instances policy
  mixed_instances_policy = {
    instances_distribution = {
      on_demand_base_capacity = 1
      on_demand_percentage_above_base_capacity = 25
      spot_allocation_strategy = "capacity-optimized"
      spot_instance_pools = 2
    }
    override = [
      {
        instance_type = "t3.medium"
        weighted_capacity = 1
      },
      {
        instance_type = "t3.large"
        weighted_capacity = 2
      },
      {
        instance_type = "m5.large"
        weighted_capacity = 3
      }
    ]
  }
  
  # Scaling policies
  scale_out_policy_name = "cost-optimized-scale-out"
  scale_out_adjustment = 1
  scale_in_policy_name = "cost-optimized-scale-in"
  scale_in_adjustment = -1
  
  # CloudWatch alarms
  scale_out_alarm_name = "cost-optimized-cpu-high"
  scale_out_threshold = 75
  scale_in_alarm_name = "cost-optimized-cpu-low"
  scale_in_threshold = 25
  
  # Tags
  common_tags = {
    Environment = "production"
    Project     = "cost-optimization"
    InstanceType = "mixed"
  }
}
```

## 📋 Inputs

### Auto Scaling Group Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create_auto_scaling_group` | Whether to create an auto scaling group | `bool` | `false` | no |
| `asg_name` | Name of the auto scaling group | `string` | `null` | yes |
| `asg_description` | Description of the auto scaling group | `string` | `null` | no |
| `subnet_id` | Subnet ID for the auto scaling group | `string` | `null` | yes |
| `desired_capacity` | Desired number of instances | `number` | `1` | no |
| `min_size` | Minimum number of instances | `number` | `1` | no |
| `max_size` | Maximum number of instances | `number` | `3` | no |

### Health Check Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `health_check_type` | Type of health check | `string` | `"EC2"` | no |
| `health_check_grace_period` | Health check grace period in seconds | `number` | `300` | no |
| `cooldown` | Cooldown period in seconds | `number` | `300` | no |

### Launch Template Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `launch_template_name` | Name of the launch template | `string` | `null` | yes |
| `launch_template_version` | Version of the launch template | `string` | `"$Latest"` | no |
| `mixed_instances_policy` | Mixed instances policy configuration | `object` | `null` | no |

### Scaling Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `enable_scale_in_protection` | Enable scale-in protection | `bool` | `false` | no |
| `enable_instance_refresh` | Enable instance refresh | `bool` | `false` | no |
| `instance_refresh_strategy` | Instance refresh strategy | `string` | `"Rolling"` | no |
| `instance_refresh_min_healthy_percentage` | Minimum healthy percentage for instance refresh | `number` | `50` | no |
| `suspended_processes` | List of suspended processes | `list(string)` | `[]` | no |

### Scaling Policies Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `scale_out_policy_name` | Name of the scale-out policy | `string` | `null` | yes |
| `scale_out_adjustment` | Scale-out adjustment | `number` | `1` | no |
| `scale_in_policy_name` | Name of the scale-in policy | `string` | `null` | yes |
| `scale_in_adjustment` | Scale-in adjustment | `number` | `-1` | no |

### CloudWatch Alarms Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `scale_out_alarm_name` | Name of the scale-out alarm | `string` | `null` | yes |
| `scale_out_threshold` | Scale-out threshold | `number` | `80` | no |
| `scale_out_alarm_description` | Description of the scale-out alarm | `string` | `null` | no |
| `scale_in_alarm_name` | Name of the scale-in alarm | `string` | `null` | yes |
| `scale_in_threshold` | Scale-in threshold | `number` | `30` | no |
| `scale_in_alarm_description` | Description of the scale-in alarm | `string` | `null` | no |
| `alarm_evaluation_periods` | Number of evaluation periods | `number` | `2` | no |
| `alarm_metric_name` | Metric name for alarms | `string` | `"CPUUtilization"` | no |
| `alarm_namespace` | Namespace for alarms | `string` | `"AWS/EC2"` | no |
| `alarm_period` | Period for alarms in seconds | `number` | `300` | no |
| `alarm_statistic` | Statistic for alarms | `string` | `"Average"` | no |

### Tagging Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `common_tags` | Common tags to apply to all resources | `map(string)` | `{}` | no |

## 📤 Outputs

### Auto Scaling Group Outputs

| Name | Description |
|------|-------------|
| `asg_id` | ID of the created auto scaling group |
| `asg_arn` | ARN of the created auto scaling group |
| `asg_name` | Name of the created auto scaling group |
| `asg_desired_capacity` | Desired capacity of the auto scaling group |
| `asg_min_size` | Minimum size of the auto scaling group |
| `asg_max_size` | Maximum size of the auto scaling group |

### Scaling Policy Outputs

| Name | Description |
|------|-------------|
| `scale_out_policy_arn` | ARN of the scale-out policy |
| `scale_out_policy_name` | Name of the scale-out policy |
| `scale_in_policy_arn` | ARN of the scale-in policy |
| `scale_in_policy_name` | Name of the scale-in policy |

### CloudWatch Alarm Outputs

| Name | Description |
|------|-------------|
| `scale_out_alarm_arn` | ARN of the scale-out alarm |
| `scale_out_alarm_name` | Name of the scale-out alarm |
| `scale_in_alarm_arn` | ARN of the scale-in alarm |
| `scale_in_alarm_name` | Name of the scale-in alarm |

## 🔧 Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## 🔗 Related Modules

- [terraform-aws-ec2-instance](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance) - EC2 instance module
- [terraform-ec2-wrapper](../terraform-ec2-wrapper) - Wrapper module that uses this autoscaling module

## 📝 Notes

- Auto Scaling Groups are region-specific resources
- Launch templates must exist before creating the ASG
- Health check grace period allows instances to start up before health checks begin
- Mixed instances policies can help optimize costs with spot instances
- Scaling policies require CloudWatch alarms to trigger scaling actions

## 🚨 Important

- Ensure the launch template exists and is properly configured
- Configure appropriate health check settings for your application
- Set reasonable scaling thresholds to avoid unnecessary scaling
- Consider using scale-in protection for critical instances
- Monitor scaling activities to ensure they meet your requirements
- Auto Scaling Groups cannot be deleted if they have active instances
