# =============================================================================
# MONITORING MODULE - CloudWatch Alarms, Dashboards, and Monitoring
# =============================================================================

# CloudWatch Alarm for CPU Utilization
resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
  count = var.create_cpu_alarm ? 1 : 0

  alarm_name          = var.cpu_alarm_name != null ? var.cpu_alarm_name : "${var.instance_name}-cpu-alarm"
  comparison_operator = var.cpu_comparison_operator
  evaluation_periods  = var.cpu_evaluation_periods
  metric_name         = var.cpu_metric_name
  namespace           = var.cpu_namespace
  period              = var.cpu_period
  statistic           = var.cpu_statistic
  threshold           = var.cpu_threshold
  alarm_description   = var.cpu_alarm_description != null ? var.cpu_alarm_description : "CPU utilization alarm for ${var.instance_name}"
  alarm_actions       = var.cpu_alarm_actions
  ok_actions          = var.cpu_ok_actions
  insufficient_data_actions = var.cpu_insufficient_data_actions
  treat_missing_data  = var.cpu_treat_missing_data
  datapoints_to_alarm = var.cpu_datapoints_to_alarm
  extended_statistic  = var.cpu_extended_statistic
  unit                = var.cpu_unit

  dimensions = var.cpu_dimensions != null ? var.cpu_dimensions : {
    InstanceId = var.instance_id
  }

  tags = merge(
    var.tags,
    {
      Name = var.cpu_alarm_name != null ? var.cpu_alarm_name : "${var.instance_name}-cpu-alarm"
      Module = "monitoring"
      Metric = var.cpu_metric_name
      InstanceId = var.instance_id
      AlarmType = "CPU"
    }
  )
}

# CloudWatch Alarm for Memory Utilization (if CloudWatch Agent is installed)
resource "aws_cloudwatch_metric_alarm" "memory_utilization" {
  count = var.create_memory_alarm ? 1 : 0

  alarm_name          = var.memory_alarm_name != null ? var.memory_alarm_name : "${var.instance_name}-memory-alarm"
  comparison_operator = var.memory_comparison_operator
  evaluation_periods  = var.memory_evaluation_periods
  metric_name         = var.memory_metric_name
  namespace           = var.memory_namespace
  period              = var.memory_period
  statistic           = var.memory_statistic
  threshold           = var.memory_threshold
  alarm_description   = var.memory_alarm_description != null ? var.memory_alarm_description : "Memory utilization alarm for ${var.instance_name}"
  alarm_actions       = var.memory_alarm_actions
  ok_actions          = var.memory_ok_actions
  insufficient_data_actions = var.memory_insufficient_data_actions
  treat_missing_data  = var.memory_treat_missing_data
  datapoints_to_alarm = var.memory_datapoints_to_alarm
  extended_statistic  = var.memory_extended_statistic
  unit                = var.memory_unit

  dimensions = var.memory_dimensions != null ? var.memory_dimensions : {
    InstanceId = var.instance_id
  }

  tags = merge(
    var.tags,
    {
      Name = var.memory_alarm_name != null ? var.memory_alarm_name : "${var.instance_name}-memory-alarm"
      Module = "monitoring"
      Metric = var.memory_metric_name
      InstanceId = var.instance_id
      AlarmType = "Memory"
    }
  )
}

# CloudWatch Alarm for Disk Utilization
resource "aws_cloudwatch_metric_alarm" "disk_utilization" {
  count = var.create_disk_alarm ? 1 : 0

  alarm_name          = var.disk_alarm_name != null ? var.disk_alarm_name : "${var.instance_name}-disk-alarm"
  comparison_operator = var.disk_comparison_operator
  evaluation_periods  = var.disk_evaluation_periods
  metric_name         = var.disk_metric_name
  namespace           = var.disk_namespace
  period              = var.disk_period
  statistic           = var.disk_statistic
  threshold           = var.disk_threshold
  alarm_description   = var.disk_alarm_description != null ? var.disk_alarm_description : "Disk utilization alarm for ${var.instance_name}"
  alarm_actions       = var.disk_alarm_actions
  ok_actions          = var.disk_ok_actions
  insufficient_data_actions = var.disk_insufficient_data_actions
  treat_missing_data  = var.disk_treat_missing_data
  datapoints_to_alarm = var.disk_datapoints_to_alarm
  extended_statistic  = var.disk_extended_statistic
  unit                = var.disk_unit

  dimensions = var.disk_dimensions != null ? var.disk_dimensions : {
    InstanceId = var.instance_id
    Filesystem = var.disk_filesystem
    MountPath = var.disk_mount_path
  }

  tags = merge(
    var.tags,
    {
      Name = var.disk_alarm_name != null ? var.disk_alarm_name : "${var.instance_name}-disk-alarm"
      Module = "monitoring"
      Metric = var.disk_metric_name
      InstanceId = var.instance_id
      AlarmType = "Disk"
    }
  )
}

# CloudWatch Alarm for Network In
resource "aws_cloudwatch_metric_alarm" "network_in" {
  count = var.create_network_in_alarm ? 1 : 0

  alarm_name          = var.network_in_alarm_name != null ? var.network_in_alarm_name : "${var.instance_name}-network-in-alarm"
  comparison_operator = var.network_in_comparison_operator
  evaluation_periods  = var.network_in_evaluation_periods
  metric_name         = var.network_in_metric_name
  namespace           = var.network_in_namespace
  period              = var.network_in_period
  statistic           = var.network_in_statistic
  threshold           = var.network_in_threshold
  alarm_description   = var.network_in_alarm_description != null ? var.network_in_alarm_description : "Network in alarm for ${var.instance_name}"
  alarm_actions       = var.network_in_alarm_actions
  ok_actions          = var.network_in_ok_actions
  insufficient_data_actions = var.network_in_insufficient_data_actions
  treat_missing_data  = var.network_in_treat_missing_data
  datapoints_to_alarm = var.network_in_datapoints_to_alarm
  extended_statistic  = var.network_in_extended_statistic
  unit                = var.network_in_unit

  dimensions = var.network_in_dimensions != null ? var.network_in_dimensions : {
    InstanceId = var.instance_id
  }

  tags = merge(
    var.tags,
    {
      Name = var.network_in_alarm_name != null ? var.network_in_alarm_name : "${var.instance_name}-network-in-alarm"
      Module = "monitoring"
      Metric = var.network_in_metric_name
      InstanceId = var.instance_id
      AlarmType = "NetworkIn"
    }
  )
}

# CloudWatch Alarm for Network Out
resource "aws_cloudwatch_metric_alarm" "network_out" {
  count = var.create_network_out_alarm ? 1 : 0

  alarm_name          = var.network_out_alarm_name != null ? var.network_out_alarm_name : "${var.instance_name}-network-out-alarm"
  comparison_operator = var.network_out_comparison_operator
  evaluation_periods  = var.network_out_evaluation_periods
  metric_name         = var.network_out_metric_name
  namespace           = var.network_out_namespace
  period              = var.network_out_period
  statistic           = var.network_out_statistic
  threshold           = var.network_out_threshold
  alarm_description   = var.network_out_alarm_description != null ? var.network_out_alarm_description : "Network out alarm for ${var.instance_name}"
  alarm_actions       = var.network_out_alarm_actions
  ok_actions          = var.network_out_ok_actions
  insufficient_data_actions = var.network_out_insufficient_data_actions
  treat_missing_data  = var.network_out_treat_missing_data
  datapoints_to_alarm = var.network_out_datapoints_to_alarm
  extended_statistic  = var.network_out_extended_statistic
  unit                = var.network_out_unit

  dimensions = var.network_out_dimensions != null ? var.network_out_dimensions : {
    InstanceId = var.instance_id
  }

  tags = merge(
    var.tags,
    {
      Name = var.network_out_alarm_name != null ? var.network_out_alarm_name : "${var.instance_name}-network-out-alarm"
      Module = "monitoring"
      Metric = var.network_out_metric_name
      InstanceId = var.instance_id
      AlarmType = "NetworkOut"
    }
  )
}

# CloudWatch Alarm for Status Check Failed
resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  count = var.create_status_check_alarm ? 1 : 0

  alarm_name          = var.status_check_alarm_name != null ? var.status_check_alarm_name : "${var.instance_name}-status-check-alarm"
  comparison_operator = var.status_check_comparison_operator
  evaluation_periods  = var.status_check_evaluation_periods
  metric_name         = var.status_check_metric_name
  namespace           = var.status_check_namespace
  period              = var.status_check_period
  statistic           = var.status_check_statistic
  threshold           = var.status_check_threshold
  alarm_description   = var.status_check_alarm_description != null ? var.status_check_alarm_description : "Status check failed alarm for ${var.instance_name}"
  alarm_actions       = var.status_check_alarm_actions
  ok_actions          = var.status_check_ok_actions
  insufficient_data_actions = var.status_check_insufficient_data_actions
  treat_missing_data  = var.status_check_treat_missing_data
  datapoints_to_alarm = var.status_check_datapoints_to_alarm
  extended_statistic  = var.status_check_extended_statistic
  unit                = var.status_check_unit

  dimensions = var.status_check_dimensions != null ? var.status_check_dimensions : {
    InstanceId = var.instance_id
  }

  tags = merge(
    var.tags,
    {
      Name = var.status_check_alarm_name != null ? var.status_check_alarm_name : "${var.instance_name}-status-check-alarm"
      Module = "monitoring"
      Metric = var.status_check_metric_name
      InstanceId = var.instance_id
      AlarmType = "StatusCheck"
    }
  )
}

# CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "instance_dashboard" {
  count = var.create_dashboard ? 1 : 0

  dashboard_name = var.dashboard_name != null ? var.dashboard_name : "${var.instance_name}-dashboard"

  dashboard_body = var.dashboard_body != null ? var.dashboard_body : jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = var.dashboard_cpu_metrics != null ? var.dashboard_cpu_metrics : [
            ["AWS/EC2", "CPUUtilization", "InstanceId", var.instance_id],
            [".", "NetworkIn", ".", "."],
            [".", "NetworkOut", ".", "."]
          ]
          period = var.dashboard_period
          stat   = var.dashboard_stat
          title  = var.dashboard_cpu_title != null ? var.dashboard_cpu_title : "EC2 Instance Metrics - ${var.instance_name}"
          view   = var.dashboard_view
          stacked = var.dashboard_stacked
          yAxis = var.dashboard_y_axis
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = var.dashboard_system_metrics != null ? var.dashboard_system_metrics : [
            ["CWAgent", "MemoryUtilization", "InstanceId", var.instance_id],
            [".", "DiskUtilization", ".", ".", "Filesystem", var.disk_filesystem, "MountPath", var.disk_mount_path]
          ]
          period = var.dashboard_period
          stat   = var.dashboard_stat
          title  = var.dashboard_system_title != null ? var.dashboard_system_title : "System Metrics - ${var.instance_name}"
          view   = var.dashboard_view
          stacked = var.dashboard_stacked
          yAxis = var.dashboard_y_axis
        }
      }
    ]
  })
}