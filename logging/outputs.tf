# =============================================================================
# LOGGING MODULE OUTPUTS
# =============================================================================

# =============================================================================
# LOG GROUP OUTPUTS
# =============================================================================

output "application_log_group" {
  description = "Application log group resource"
  value       = var.create_application_log_group ? aws_cloudwatch_log_group.application_logs[0] : null
}

output "application_log_group_name" {
  description = "Name of the application log group"
  value       = var.create_application_log_group ? aws_cloudwatch_log_group.application_logs[0].name : null
}

output "application_log_group_arn" {
  description = "ARN of the application log group"
  value       = var.create_application_log_group ? aws_cloudwatch_log_group.application_logs[0].arn : null
}

output "system_log_group" {
  description = "System log group resource"
  value       = var.create_system_log_group ? aws_cloudwatch_log_group.system_logs[0] : null
}

output "system_log_group_name" {
  description = "Name of the system log group"
  value       = var.create_system_log_group ? aws_cloudwatch_log_group.system_logs[0].name : null
}

output "system_log_group_arn" {
  description = "ARN of the system log group"
  value       = var.create_system_log_group ? aws_cloudwatch_log_group.system_logs[0].arn : null
}

output "access_log_group" {
  description = "Access log group resource"
  value       = var.create_access_log_group ? aws_cloudwatch_log_group.access_logs[0] : null
}

output "access_log_group_name" {
  description = "Name of the access log group"
  value       = var.create_access_log_group ? aws_cloudwatch_log_group.access_logs[0].name : null
}

output "access_log_group_arn" {
  description = "ARN of the access log group"
  value       = var.create_access_log_group ? aws_cloudwatch_log_group.access_logs[0].arn : null
}

output "error_log_group" {
  description = "Error log group resource"
  value       = var.create_error_log_group ? aws_cloudwatch_log_group.error_logs[0] : null
}

output "error_log_group_name" {
  description = "Name of the error log group"
  value       = var.create_error_log_group ? aws_cloudwatch_log_group.error_logs[0].name : null
}

output "error_log_group_arn" {
  description = "ARN of the error log group"
  value       = var.create_error_log_group ? aws_cloudwatch_log_group.error_logs[0].arn : null
}

output "custom_log_groups" {
  description = "Map of custom log group resources"
  value       = aws_cloudwatch_log_group.custom_logs
}

output "custom_log_group_names" {
  description = "Map of custom log group names"
  value       = { for k, v in aws_cloudwatch_log_group.custom_logs : k => v.name }
}

output "custom_log_group_arns" {
  description = "Map of custom log group ARNs"
  value       = { for k, v in aws_cloudwatch_log_group.custom_logs : k => v.arn }
}

# =============================================================================
# LOG STREAM OUTPUTS
# =============================================================================

output "application_log_stream" {
  description = "Application log stream resource"
  value       = var.create_application_log_stream ? aws_cloudwatch_log_stream.application_log_stream[0] : null
}

output "application_log_stream_name" {
  description = "Name of the application log stream"
  value       = var.create_application_log_stream ? aws_cloudwatch_log_stream.application_log_stream[0].name : null
}

output "system_log_stream" {
  description = "System log stream resource"
  value       = var.create_system_log_stream ? aws_cloudwatch_log_stream.system_log_stream[0] : null
}

output "system_log_stream_name" {
  description = "Name of the system log stream"
  value       = var.create_system_log_stream ? aws_cloudwatch_log_stream.system_log_stream[0].name : null
}

output "access_log_stream" {
  description = "Access log stream resource"
  value       = var.create_access_log_stream ? aws_cloudwatch_log_stream.access_log_stream[0] : null
}

output "access_log_stream_name" {
  description = "Name of the access log stream"
  value       = var.create_access_log_stream ? aws_cloudwatch_log_stream.access_log_stream[0].name : null
}

output "error_log_stream" {
  description = "Error log stream resource"
  value       = var.create_error_log_stream ? aws_cloudwatch_log_stream.error_log_stream[0] : null
}

output "error_log_stream_name" {
  description = "Name of the error log stream"
  value       = var.create_error_log_stream ? aws_cloudwatch_log_stream.error_log_stream[0].name : null
}

output "custom_log_streams" {
  description = "Map of custom log stream resources"
  value       = aws_cloudwatch_log_stream.custom_log_streams
}

output "custom_log_stream_names" {
  description = "Map of custom log stream names"
  value       = { for k, v in aws_cloudwatch_log_stream.custom_log_streams : k => v.name }
}

# =============================================================================
# METRIC FILTER OUTPUTS
# =============================================================================

output "error_metric_filter" {
  description = "Error metric filter resource"
  value       = var.create_error_metric_filter ? aws_cloudwatch_log_metric_filter.error_filter[0] : null
}

output "error_metric_filter_name" {
  description = "Name of the error metric filter"
  value       = var.create_error_metric_filter ? aws_cloudwatch_log_metric_filter.error_filter[0].name : null
}

output "access_metric_filter" {
  description = "Access metric filter resource"
  value       = var.create_access_metric_filter ? aws_cloudwatch_log_metric_filter.access_filter[0] : null
}

output "access_metric_filter_name" {
  description = "Name of the access metric filter"
  value       = var.create_access_metric_filter ? aws_cloudwatch_log_metric_filter.access_filter[0].name : null
}

output "custom_metric_filters" {
  description = "Map of custom metric filter resources"
  value       = aws_cloudwatch_log_metric_filter.custom_filters
}

output "custom_metric_filter_names" {
  description = "Map of custom metric filter names"
  value       = { for k, v in aws_cloudwatch_log_metric_filter.custom_filters : k => v.name }
}

# =============================================================================
# LOG ALARM OUTPUTS
# =============================================================================

output "error_log_alarm" {
  description = "Error log alarm resource"
  value       = var.create_error_log_alarm ? aws_cloudwatch_metric_alarm.error_log_alarm[0] : null
}

output "error_log_alarm_name" {
  description = "Name of the error log alarm"
  value       = var.create_error_log_alarm ? aws_cloudwatch_metric_alarm.error_log_alarm[0].alarm_name : null
}

output "error_log_alarm_arn" {
  description = "ARN of the error log alarm"
  value       = var.create_error_log_alarm ? aws_cloudwatch_metric_alarm.error_log_alarm[0].arn : null
}

output "access_log_alarm" {
  description = "Access log alarm resource"
  value       = var.create_access_log_alarm ? aws_cloudwatch_metric_alarm.access_log_alarm[0] : null
}

output "access_log_alarm_name" {
  description = "Name of the access log alarm"
  value       = var.create_access_log_alarm ? aws_cloudwatch_metric_alarm.access_log_alarm[0].alarm_name : null
}

output "access_log_alarm_arn" {
  description = "ARN of the access log alarm"
  value       = var.create_access_log_alarm ? aws_cloudwatch_metric_alarm.access_log_alarm[0].arn : null
}

output "custom_log_alarms" {
  description = "Map of custom log alarm resources"
  value       = aws_cloudwatch_metric_alarm.custom_log_alarms
}

output "custom_log_alarm_names" {
  description = "Map of custom log alarm names"
  value       = { for k, v in aws_cloudwatch_metric_alarm.custom_log_alarms : k => v.alarm_name }
}

output "custom_log_alarm_arns" {
  description = "Map of custom log alarm ARNs"
  value       = { for k, v in aws_cloudwatch_metric_alarm.custom_log_alarms : k => v.arn }
}

# =============================================================================
# SUMMARY OUTPUTS
# =============================================================================

output "all_log_groups" {
  description = "Map of all log group resources"
  value = {
    application = var.create_application_log_group ? aws_cloudwatch_log_group.application_logs[0] : null
    system      = var.create_system_log_group ? aws_cloudwatch_log_group.system_logs[0] : null
    access      = var.create_access_log_group ? aws_cloudwatch_log_group.access_logs[0] : null
    error       = var.create_error_log_group ? aws_cloudwatch_log_group.error_logs[0] : null
    custom      = aws_cloudwatch_log_group.custom_logs
  }
}

output "all_log_streams" {
  description = "Map of all log stream resources"
  value = {
    application = var.create_application_log_stream ? aws_cloudwatch_log_stream.application_log_stream[0] : null
    system      = var.create_system_log_stream ? aws_cloudwatch_log_stream.system_log_stream[0] : null
    access      = var.create_access_log_stream ? aws_cloudwatch_log_stream.access_log_stream[0] : null
    error       = var.create_error_log_stream ? aws_cloudwatch_log_stream.error_log_stream[0] : null
    custom      = aws_cloudwatch_log_stream.custom_log_streams
  }
}

output "all_metric_filters" {
  description = "Map of all metric filter resources"
  value = {
    error  = var.create_error_metric_filter ? aws_cloudwatch_log_metric_filter.error_filter[0] : null
    access = var.create_access_metric_filter ? aws_cloudwatch_log_metric_filter.access_filter[0] : null
    custom = aws_cloudwatch_log_metric_filter.custom_filters
  }
}

output "all_log_alarms" {
  description = "Map of all log alarm resources"
  value = {
    error  = var.create_error_log_alarm ? aws_cloudwatch_metric_alarm.error_log_alarm[0] : null
    access = var.create_access_log_alarm ? aws_cloudwatch_metric_alarm.access_log_alarm[0] : null
    custom = aws_cloudwatch_metric_alarm.custom_log_alarms
  }
}

output "logging_summary" {
  description = "Summary of all logging resources created"
  value = {
    instance_name = var.instance_name
    log_groups = {
      application = var.create_application_log_group
      system      = var.create_system_log_group
      access      = var.create_access_log_group
      error       = var.create_error_log_group
      custom      = length(var.custom_log_groups)
    }
    log_streams = {
      application = var.create_application_log_stream
      system      = var.create_system_log_stream
      access      = var.create_access_log_stream
      error       = var.create_error_log_stream
      custom      = length(var.custom_log_streams)
    }
    metric_filters = {
      error  = var.create_error_metric_filter
      access = var.create_access_metric_filter
      custom = length(var.custom_metric_filters)
    }
    alarms = {
      error  = var.create_error_log_alarm
      access = var.create_access_log_alarm
      custom = length(var.custom_log_alarms)
    }
  }
}
