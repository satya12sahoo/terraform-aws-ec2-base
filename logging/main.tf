# =============================================================================
# LOGGING MODULE - CloudWatch Logs, Log Groups, and Log Streams
# =============================================================================

# CloudWatch Log Group for application logs
resource "aws_cloudwatch_log_group" "application_logs" {
  count = var.create_application_log_group ? 1 : 0

  name              = var.application_log_group_name != null ? var.application_log_group_name : "${var.instance_name}-application-logs"
  retention_in_days = var.application_log_retention_days
  kms_key_id        = var.application_log_group_kms_key_id
  skip_destroy      = var.application_log_group_skip_destroy

  tags = merge(
    var.tags,
    {
      Name = var.application_log_group_name != null ? var.application_log_group_name : "${var.instance_name}-application-logs"
      Module = "logging"
      LogType = "application"
      RetentionDays = var.application_log_retention_days
      Encrypted = var.application_log_group_kms_key_id != null
    }
  )
}

# CloudWatch Log Group for system logs
resource "aws_cloudwatch_log_group" "system_logs" {
  count = var.create_system_log_group ? 1 : 0

  name              = var.system_log_group_name != null ? var.system_log_group_name : "${var.instance_name}-system-logs"
  retention_in_days = var.system_log_retention_days
  kms_key_id        = var.system_log_group_kms_key_id
  skip_destroy      = var.system_log_group_skip_destroy

  tags = merge(
    var.tags,
    {
      Name = var.system_log_group_name != null ? var.system_log_group_name : "${var.instance_name}-system-logs"
      Module = "logging"
      LogType = "system"
      RetentionDays = var.system_log_retention_days
      Encrypted = var.system_log_group_kms_key_id != null
    }
  )
}

# CloudWatch Log Group for access logs
resource "aws_cloudwatch_log_group" "access_logs" {
  count = var.create_access_log_group ? 1 : 0

  name              = var.access_log_group_name != null ? var.access_log_group_name : "${var.instance_name}-access-logs"
  retention_in_days = var.access_log_retention_days
  kms_key_id        = var.access_log_group_kms_key_id
  skip_destroy      = var.access_log_group_skip_destroy

  tags = merge(
    var.tags,
    {
      Name = var.access_log_group_name != null ? var.access_log_group_name : "${var.instance_name}-access-logs"
      Module = "logging"
      LogType = "access"
      RetentionDays = var.access_log_retention_days
      Encrypted = var.access_log_group_kms_key_id != null
    }
  )
}

# CloudWatch Log Group for error logs
resource "aws_cloudwatch_log_group" "error_logs" {
  count = var.create_error_log_group ? 1 : 0

  name              = var.error_log_group_name != null ? var.error_log_group_name : "${var.instance_name}-error-logs"
  retention_in_days = var.error_log_retention_days
  kms_key_id        = var.error_log_group_kms_key_id
  skip_destroy      = var.error_log_group_skip_destroy

  tags = merge(
    var.tags,
    {
      Name = var.error_log_group_name != null ? var.error_log_group_name : "${var.instance_name}-error-logs"
      Module = "logging"
      LogType = "error"
      RetentionDays = var.error_log_retention_days
      Encrypted = var.error_log_group_kms_key_id != null
    }
  )
}

# CloudWatch Log Group for custom logs
resource "aws_cloudwatch_log_group" "custom_logs" {
  for_each = var.custom_log_groups

  name              = each.value.name != null ? each.value.name : "${var.instance_name}-${each.key}-logs"
  retention_in_days = each.value.retention_days != null ? each.value.retention_days : var.default_custom_log_retention_days
  kms_key_id        = each.value.kms_key_id
  skip_destroy      = each.value.skip_destroy != null ? each.value.skip_destroy : var.default_custom_log_skip_destroy

  tags = merge(
    var.tags,
    each.value.tags != null ? each.value.tags : {},
    {
      Name = each.value.name != null ? each.value.name : "${var.instance_name}-${each.key}-logs"
      Module = "logging"
      LogType = "custom"
      LogCategory = each.key
      RetentionDays = each.value.retention_days != null ? each.value.retention_days : var.default_custom_log_retention_days
      Encrypted = each.value.kms_key_id != null
    }
  )
}

# CloudWatch Log Stream for application logs
resource "aws_cloudwatch_log_stream" "application_log_stream" {
  count = var.create_application_log_stream ? 1 : 0

  name           = var.application_log_stream_name != null ? var.application_log_stream_name : "${var.instance_name}-application-stream"
  log_group_name = aws_cloudwatch_log_group.application_logs[0].name
}

# CloudWatch Log Stream for system logs
resource "aws_cloudwatch_log_stream" "system_log_stream" {
  count = var.create_system_log_stream ? 1 : 0

  name           = var.system_log_stream_name != null ? var.system_log_stream_name : "${var.instance_name}-system-stream"
  log_group_name = aws_cloudwatch_log_group.system_logs[0].name
}

# CloudWatch Log Stream for access logs
resource "aws_cloudwatch_log_stream" "access_log_stream" {
  count = var.create_access_log_stream ? 1 : 0

  name           = var.access_log_stream_name != null ? var.access_log_stream_name : "${var.instance_name}-access-stream"
  log_group_name = aws_cloudwatch_log_group.access_logs[0].name
}

# CloudWatch Log Stream for error logs
resource "aws_cloudwatch_log_stream" "error_log_stream" {
  count = var.create_error_log_stream ? 1 : 0

  name           = var.error_log_stream_name != null ? var.error_log_stream_name : "${var.instance_name}-error-stream"
  log_group_name = aws_cloudwatch_log_group.error_logs[0].name
}

# CloudWatch Log Streams for custom logs
resource "aws_cloudwatch_log_stream" "custom_log_streams" {
  for_each = var.custom_log_streams

  name           = each.value.name != null ? each.value.name : "${var.instance_name}-${each.key}-stream"
  log_group_name = aws_cloudwatch_log_group.custom_logs[each.value.log_group_key].name
}

# CloudWatch Log Metric Filter for error detection
resource "aws_cloudwatch_log_metric_filter" "error_filter" {
  count = var.create_error_metric_filter ? 1 : 0

  name           = var.error_metric_filter_name != null ? var.error_metric_filter_name : "${var.instance_name}-error-filter"
  pattern        = var.error_metric_filter_pattern
  log_group_name = aws_cloudwatch_log_group.error_logs[0].name

  metric_transformation {
    name          = var.error_metric_name != null ? var.error_metric_name : "${var.instance_name}-error-count"
    namespace     = var.error_metric_namespace != null ? var.error_metric_namespace : "EC2/Logs"
    value         = var.error_metric_value
    default_value = var.error_metric_default_value
  }
}

# CloudWatch Log Metric Filter for access pattern detection
resource "aws_cloudwatch_log_metric_filter" "access_filter" {
  count = var.create_access_metric_filter ? 1 : 0

  name           = var.access_metric_filter_name != null ? var.access_metric_filter_name : "${var.instance_name}-access-filter"
  pattern        = var.access_metric_filter_pattern
  log_group_name = aws_cloudwatch_log_group.access_logs[0].name

  metric_transformation {
    name          = var.access_metric_name != null ? var.access_metric_name : "${var.instance_name}-access-count"
    namespace     = var.access_metric_namespace != null ? var.access_metric_namespace : "EC2/Logs"
    value         = var.access_metric_value
    default_value = var.access_metric_default_value
  }
}

# CloudWatch Log Metric Filters for custom patterns
resource "aws_cloudwatch_log_metric_filter" "custom_filters" {
  for_each = var.custom_metric_filters

  name           = each.value.name != null ? each.value.name : "${var.instance_name}-${each.key}-filter"
  pattern        = each.value.pattern
  log_group_name = aws_cloudwatch_log_group.custom_logs[each.value.log_group_key].name

  metric_transformation {
    name          = each.value.metric_name != null ? each.value.metric_name : "${var.instance_name}-${each.key}-count"
    namespace     = each.value.metric_namespace != null ? each.value.metric_namespace : "EC2/Logs"
    value         = each.value.metric_value
    default_value = each.value.metric_default_value
  }
}

# CloudWatch Alarm for error log rate
resource "aws_cloudwatch_metric_alarm" "error_log_alarm" {
  count = var.create_error_log_alarm ? 1 : 0

  alarm_name          = var.error_log_alarm_name != null ? var.error_log_alarm_name : "${var.instance_name}-error-log-alarm"
  comparison_operator = var.error_log_alarm_comparison_operator
  evaluation_periods  = var.error_log_alarm_evaluation_periods
  metric_name         = var.error_metric_name != null ? var.error_metric_name : "${var.instance_name}-error-count"
  namespace           = var.error_metric_namespace != null ? var.error_metric_namespace : "EC2/Logs"
  period              = var.error_log_alarm_period
  statistic           = var.error_log_alarm_statistic
  threshold           = var.error_log_alarm_threshold
  alarm_description   = var.error_log_alarm_description != null ? var.error_log_alarm_description : "Error log rate alarm for ${var.instance_name}"
  alarm_actions       = var.error_log_alarm_actions
  ok_actions          = var.error_log_alarm_ok_actions
  treat_missing_data  = var.error_log_alarm_treat_missing_data

  tags = merge(
    var.tags,
    {
      Name = var.error_log_alarm_name != null ? var.error_log_alarm_name : "${var.instance_name}-error-log-alarm"
      Module = "logging"
      AlarmType = "ErrorLog"
    }
  )
}

# CloudWatch Alarm for access log rate
resource "aws_cloudwatch_metric_alarm" "access_log_alarm" {
  count = var.create_access_log_alarm ? 1 : 0

  alarm_name          = var.access_log_alarm_name != null ? var.access_log_alarm_name : "${var.instance_name}-access-log-alarm"
  comparison_operator = var.access_log_alarm_comparison_operator
  evaluation_periods  = var.access_log_alarm_evaluation_periods
  metric_name         = var.access_metric_name != null ? var.access_metric_name : "${var.instance_name}-access-count"
  namespace           = var.access_metric_namespace != null ? var.access_metric_namespace : "EC2/Logs"
  period              = var.access_log_alarm_period
  statistic           = var.access_log_alarm_statistic
  threshold           = var.access_log_alarm_threshold
  alarm_description   = var.access_log_alarm_description != null ? var.access_log_alarm_description : "Access log rate alarm for ${var.instance_name}"
  alarm_actions       = var.access_log_alarm_actions
  ok_actions          = var.access_log_alarm_ok_actions
  treat_missing_data  = var.access_log_alarm_treat_missing_data

  tags = merge(
    var.tags,
    {
      Name = var.access_log_alarm_name != null ? var.access_log_alarm_name : "${var.instance_name}-access-log-alarm"
      Module = "logging"
      AlarmType = "AccessLog"
    }
  )
}

# CloudWatch Alarms for custom metric filters
resource "aws_cloudwatch_metric_alarm" "custom_log_alarms" {
  for_each = var.custom_log_alarms

  alarm_name          = each.value.alarm_name != null ? each.value.alarm_name : "${var.instance_name}-${each.key}-log-alarm"
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  metric_name         = each.value.metric_name != null ? each.value.metric_name : "${var.instance_name}-${each.key}-count"
  namespace           = each.value.metric_namespace != null ? each.value.metric_namespace : "EC2/Logs"
  period              = each.value.period
  statistic           = each.value.statistic
  threshold           = each.value.threshold
  alarm_description   = each.value.alarm_description != null ? each.value.alarm_description : "${each.key} log rate alarm for ${var.instance_name}"
  alarm_actions       = each.value.alarm_actions
  ok_actions          = each.value.ok_actions
  treat_missing_data  = each.value.treat_missing_data

  tags = merge(
    var.tags,
    each.value.tags != null ? each.value.tags : {},
    {
      Name = each.value.alarm_name != null ? each.value.alarm_name : "${var.instance_name}-${each.key}-log-alarm"
      Module = "logging"
      AlarmType = "CustomLog"
      LogCategory = each.key
    }
  )
}
