# =============================================================================
# MONITORING MODULE OUTPUTS
# =============================================================================

# CPU Alarm Outputs
output "cpu_alarm" {
  description = "CPU utilization alarm"
  value = var.create_cpu_alarm ? aws_cloudwatch_metric_alarm.cpu_utilization[0] : null
}

output "cpu_alarm_arn" {
  description = "ARN of the CPU utilization alarm"
  value = var.create_cpu_alarm ? aws_cloudwatch_metric_alarm.cpu_utilization[0].arn : null
}

output "cpu_alarm_name" {
  description = "Name of the CPU utilization alarm"
  value = var.create_cpu_alarm ? aws_cloudwatch_metric_alarm.cpu_utilization[0].alarm_name : null
}

# Memory Alarm Outputs
output "memory_alarm" {
  description = "Memory utilization alarm"
  value = var.create_memory_alarm ? aws_cloudwatch_metric_alarm.memory_utilization[0] : null
}

output "memory_alarm_arn" {
  description = "ARN of the memory utilization alarm"
  value = var.create_memory_alarm ? aws_cloudwatch_metric_alarm.memory_utilization[0].arn : null
}

output "memory_alarm_name" {
  description = "Name of the memory utilization alarm"
  value = var.create_memory_alarm ? aws_cloudwatch_metric_alarm.memory_utilization[0].alarm_name : null
}

# Disk Alarm Outputs
output "disk_alarm" {
  description = "Disk utilization alarm"
  value = var.create_disk_alarm ? aws_cloudwatch_metric_alarm.disk_utilization[0] : null
}

output "disk_alarm_arn" {
  description = "ARN of the disk utilization alarm"
  value = var.create_disk_alarm ? aws_cloudwatch_metric_alarm.disk_utilization[0].arn : null
}

output "disk_alarm_name" {
  description = "Name of the disk utilization alarm"
  value = var.create_disk_alarm ? aws_cloudwatch_metric_alarm.disk_utilization[0].alarm_name : null
}

# Network In Alarm Outputs
output "network_in_alarm" {
  description = "Network in alarm"
  value = var.create_network_in_alarm ? aws_cloudwatch_metric_alarm.network_in[0] : null
}

output "network_in_alarm_arn" {
  description = "ARN of the network in alarm"
  value = var.create_network_in_alarm ? aws_cloudwatch_metric_alarm.network_in[0].arn : null
}

output "network_in_alarm_name" {
  description = "Name of the network in alarm"
  value = var.create_network_in_alarm ? aws_cloudwatch_metric_alarm.network_in[0].alarm_name : null
}

# Network Out Alarm Outputs
output "network_out_alarm" {
  description = "Network out alarm"
  value = var.create_network_out_alarm ? aws_cloudwatch_metric_alarm.network_out[0] : null
}

output "network_out_alarm_arn" {
  description = "ARN of the network out alarm"
  value = var.create_network_out_alarm ? aws_cloudwatch_metric_alarm.network_out[0].arn : null
}

output "network_out_alarm_name" {
  description = "Name of the network out alarm"
  value = var.create_network_out_alarm ? aws_cloudwatch_metric_alarm.network_out[0].alarm_name : null
}

# Status Check Alarm Outputs
output "status_check_alarm" {
  description = "Status check failed alarm"
  value = var.create_status_check_alarm ? aws_cloudwatch_metric_alarm.status_check_failed[0] : null
}

output "status_check_alarm_arn" {
  description = "ARN of the status check failed alarm"
  value = var.create_status_check_alarm ? aws_cloudwatch_metric_alarm.status_check_failed[0].arn : null
}

output "status_check_alarm_name" {
  description = "Name of the status check failed alarm"
  value = var.create_status_check_alarm ? aws_cloudwatch_metric_alarm.status_check_failed[0].alarm_name : null
}

# Dashboard Outputs
output "dashboard" {
  description = "CloudWatch dashboard"
  value = var.create_dashboard ? aws_cloudwatch_dashboard.instance_dashboard[0] : null
}

output "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  value = var.create_dashboard ? aws_cloudwatch_dashboard.instance_dashboard[0].dashboard_name : null
}

output "dashboard_arn" {
  description = "ARN of the CloudWatch dashboard"
  value = var.create_dashboard ? aws_cloudwatch_dashboard.instance_dashboard[0].dashboard_arn : null
}

# Combined Outputs
output "all_alarms" {
  description = "Map of all created alarms"
  value = {
    cpu_utilization = var.create_cpu_alarm ? aws_cloudwatch_metric_alarm.cpu_utilization[0] : null
    memory_utilization = var.create_memory_alarm ? aws_cloudwatch_metric_alarm.memory_utilization[0] : null
    disk_utilization = var.create_disk_alarm ? aws_cloudwatch_metric_alarm.disk_utilization[0] : null
    network_in = var.create_network_in_alarm ? aws_cloudwatch_metric_alarm.network_in[0] : null
    network_out = var.create_network_out_alarm ? aws_cloudwatch_metric_alarm.network_out[0] : null
    status_check_failed = var.create_status_check_alarm ? aws_cloudwatch_metric_alarm.status_check_failed[0] : null
  }
}

output "all_alarm_arns" {
  description = "Map of all alarm ARNs"
  value = {
    cpu_utilization = var.create_cpu_alarm ? aws_cloudwatch_metric_alarm.cpu_utilization[0].arn : null
    memory_utilization = var.create_memory_alarm ? aws_cloudwatch_metric_alarm.memory_utilization[0].arn : null
    disk_utilization = var.create_disk_alarm ? aws_cloudwatch_metric_alarm.disk_utilization[0].arn : null
    network_in = var.create_network_in_alarm ? aws_cloudwatch_metric_alarm.network_in[0].arn : null
    network_out = var.create_network_out_alarm ? aws_cloudwatch_metric_alarm.network_out[0].arn : null
    status_check_failed = var.create_status_check_alarm ? aws_cloudwatch_metric_alarm.status_check_failed[0].arn : null
  }
}

output "all_alarm_names" {
  description = "Map of all alarm names"
  value = {
    cpu_utilization = var.create_cpu_alarm ? aws_cloudwatch_metric_alarm.cpu_utilization[0].alarm_name : null
    memory_utilization = var.create_memory_alarm ? aws_cloudwatch_metric_alarm.memory_utilization[0].alarm_name : null
    disk_utilization = var.create_disk_alarm ? aws_cloudwatch_metric_alarm.disk_utilization[0].alarm_name : null
    network_in = var.create_network_in_alarm ? aws_cloudwatch_metric_alarm.network_in[0].alarm_name : null
    network_out = var.create_network_out_alarm ? aws_cloudwatch_metric_alarm.network_out[0].alarm_name : null
    status_check_failed = var.create_status_check_alarm ? aws_cloudwatch_metric_alarm.status_check_failed[0].alarm_name : null
  }
}

output "monitoring_summary" {
  description = "Summary of monitoring resources created"
  value = {
    instance_id = var.instance_id
    instance_name = var.instance_name
    alarms_created = {
      cpu = var.create_cpu_alarm
      memory = var.create_memory_alarm
      disk = var.create_disk_alarm
      network_in = var.create_network_in_alarm
      network_out = var.create_network_out_alarm
      status_check = var.create_status_check_alarm
    }
    dashboard_created = var.create_dashboard
    total_alarms = (
      (var.create_cpu_alarm ? 1 : 0) +
      (var.create_memory_alarm ? 1 : 0) +
      (var.create_disk_alarm ? 1 : 0) +
      (var.create_network_in_alarm ? 1 : 0) +
      (var.create_network_out_alarm ? 1 : 0) +
      (var.create_status_check_alarm ? 1 : 0)
    )
  }
}
