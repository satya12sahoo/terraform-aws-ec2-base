# =============================================================================
# MONITORING MODULE VARIABLES
# =============================================================================

variable "instance_id" {
  description = "The ID of the EC2 instance to monitor"
  type = string
}

variable "instance_name" {
  description = "The name of the EC2 instance for dashboard and alarm naming"
  type = string
}

variable "tags" {
  description = "Tags to apply to all monitoring resources"
  type = map(string)
  default = {}
}

# =============================================================================
# CPU ALARM VARIABLES
# =============================================================================

variable "create_cpu_alarm" {
  description = "Whether to create a CPU utilization alarm"
  type = bool
  default = true
}

variable "cpu_alarm_name" {
  description = "Name for the CPU utilization alarm (auto-generated if null)"
  type = string
  default = null
}

variable "cpu_comparison_operator" {
  description = "Comparison operator for CPU alarm"
  type = string
  default = "GreaterThanThreshold"
}

variable "cpu_evaluation_periods" {
  description = "Number of evaluation periods for CPU alarm"
  type = number
  default = 2
}

variable "cpu_period" {
  description = "Period in seconds for CPU alarm"
  type = number
  default = 300
}

variable "cpu_statistic" {
  description = "Statistic for CPU alarm"
  type = string
  default = "Average"
}

variable "cpu_threshold" {
  description = "Threshold percentage for CPU alarm"
  type = number
  default = 80
}

variable "cpu_alarm_description" {
  description = "Description for CPU alarm (auto-generated if null)"
  type = string
  default = null
}

variable "cpu_alarm_actions" {
  description = "List of ARNs to notify when CPU alarm triggers"
  type = list(string)
  default = []
}

variable "cpu_ok_actions" {
  description = "List of ARNs to notify when CPU alarm returns to OK state"
  type = list(string)
  default = []
}

variable "cpu_insufficient_data_actions" {
  description = "List of ARNs to notify when CPU alarm has insufficient data"
  type = list(string)
  default = []
}

variable "cpu_treat_missing_data" {
  description = "How to treat missing data for CPU alarm"
  type = string
  default = null
}

variable "cpu_datapoints_to_alarm" {
  description = "Number of datapoints that must be breaching to trigger CPU alarm"
  type = number
  default = null
}

variable "cpu_extended_statistic" {
  description = "Extended statistic for CPU alarm"
  type = string
  default = null
}

variable "cpu_unit" {
  description = "Unit for CPU alarm"
  type = string
  default = "Percent"
}

variable "cpu_metric_name" {
  description = "Metric name for CPU alarm"
  type = string
  default = "CPUUtilization"
}

variable "cpu_namespace" {
  description = "Namespace for CPU alarm"
  type = string
  default = "AWS/EC2"
}

variable "cpu_dimensions" {
  description = "Dimensions for CPU alarm (auto-generated if null)"
  type = map(string)
  default = null
}

# =============================================================================
# MEMORY ALARM VARIABLES
# =============================================================================

variable "create_memory_alarm" {
  description = "Whether to create a memory utilization alarm (requires CloudWatch Agent)"
  type = bool
  default = false
}

variable "memory_alarm_name" {
  description = "Name for the memory utilization alarm (auto-generated if null)"
  type = string
  default = null
}

variable "memory_comparison_operator" {
  description = "Comparison operator for memory alarm"
  type = string
  default = "GreaterThanThreshold"
}

variable "memory_evaluation_periods" {
  description = "Number of evaluation periods for memory alarm"
  type = number
  default = 2
}

variable "memory_period" {
  description = "Period in seconds for memory alarm"
  type = number
  default = 300
}

variable "memory_statistic" {
  description = "Statistic for memory alarm"
  type = string
  default = "Average"
}

variable "memory_threshold" {
  description = "Threshold percentage for memory alarm"
  type = number
  default = 85
}

variable "memory_alarm_description" {
  description = "Description for memory alarm (auto-generated if null)"
  type = string
  default = null
}

variable "memory_alarm_actions" {
  description = "List of ARNs to notify when memory alarm triggers"
  type = list(string)
  default = []
}

variable "memory_ok_actions" {
  description = "List of ARNs to notify when memory alarm returns to OK state"
  type = list(string)
  default = []
}

variable "memory_insufficient_data_actions" {
  description = "List of ARNs to notify when memory alarm has insufficient data"
  type = list(string)
  default = []
}

variable "memory_treat_missing_data" {
  description = "How to treat missing data for memory alarm"
  type = string
  default = null
}

variable "memory_datapoints_to_alarm" {
  description = "Number of datapoints that must be breaching to trigger memory alarm"
  type = number
  default = null
}

variable "memory_extended_statistic" {
  description = "Extended statistic for memory alarm"
  type = string
  default = null
}

variable "memory_unit" {
  description = "Unit for memory alarm"
  type = string
  default = "Percent"
}

variable "memory_metric_name" {
  description = "Metric name for memory alarm"
  type = string
  default = "MemoryUtilization"
}

variable "memory_namespace" {
  description = "Namespace for memory alarm"
  type = string
  default = "CWAgent"
}

variable "memory_dimensions" {
  description = "Dimensions for memory alarm (auto-generated if null)"
  type = map(string)
  default = null
}

# =============================================================================
# DISK ALARM VARIABLES
# =============================================================================

variable "create_disk_alarm" {
  description = "Whether to create a disk utilization alarm (requires CloudWatch Agent)"
  type = bool
  default = false
}

variable "disk_alarm_name" {
  description = "Name for the disk utilization alarm (auto-generated if null)"
  type = string
  default = null
}

variable "disk_comparison_operator" {
  description = "Comparison operator for disk alarm"
  type = string
  default = "GreaterThanThreshold"
}

variable "disk_evaluation_periods" {
  description = "Number of evaluation periods for disk alarm"
  type = number
  default = 2
}

variable "disk_period" {
  description = "Period in seconds for disk alarm"
  type = number
  default = 300
}

variable "disk_statistic" {
  description = "Statistic for disk alarm"
  type = string
  default = "Average"
}

variable "disk_threshold" {
  description = "Threshold percentage for disk alarm"
  type = number
  default = 85
}

variable "disk_alarm_description" {
  description = "Description for disk alarm (auto-generated if null)"
  type = string
  default = null
}

variable "disk_alarm_actions" {
  description = "List of ARNs to notify when disk alarm triggers"
  type = list(string)
  default = []
}

variable "disk_ok_actions" {
  description = "List of ARNs to notify when disk alarm returns to OK state"
  type = list(string)
  default = []
}

variable "disk_insufficient_data_actions" {
  description = "List of ARNs to notify when disk alarm has insufficient data"
  type = list(string)
  default = []
}

variable "disk_treat_missing_data" {
  description = "How to treat missing data for disk alarm"
  type = string
  default = null
}

variable "disk_datapoints_to_alarm" {
  description = "Number of datapoints that must be breaching to trigger disk alarm"
  type = number
  default = null
}

variable "disk_extended_statistic" {
  description = "Extended statistic for disk alarm"
  type = string
  default = null
}

variable "disk_unit" {
  description = "Unit for disk alarm"
  type = string
  default = "Percent"
}

variable "disk_metric_name" {
  description = "Metric name for disk alarm"
  type = string
  default = "DiskUtilization"
}

variable "disk_namespace" {
  description = "Namespace for disk alarm"
  type = string
  default = "CWAgent"
}

variable "disk_dimensions" {
  description = "Dimensions for disk alarm (auto-generated if null)"
  type = map(string)
  default = null
}

variable "disk_filesystem" {
  description = "Filesystem to monitor for disk utilization"
  type = string
  default = "/dev/xvda1"
}

variable "disk_mount_path" {
  description = "Mount path to monitor for disk utilization"
  type = string
  default = "/"
}

# =============================================================================
# NETWORK IN ALARM VARIABLES
# =============================================================================

variable "create_network_in_alarm" {
  description = "Whether to create a network in alarm"
  type = bool
  default = false
}

variable "network_in_alarm_name" {
  description = "Name for the network in alarm (auto-generated if null)"
  type = string
  default = null
}

variable "network_in_comparison_operator" {
  description = "Comparison operator for network in alarm"
  type = string
  default = "GreaterThanThreshold"
}

variable "network_in_evaluation_periods" {
  description = "Number of evaluation periods for network in alarm"
  type = number
  default = 2
}

variable "network_in_period" {
  description = "Period in seconds for network in alarm"
  type = number
  default = 300
}

variable "network_in_statistic" {
  description = "Statistic for network in alarm"
  type = string
  default = "Average"
}

variable "network_in_threshold" {
  description = "Threshold in bytes for network in alarm"
  type = number
  default = 1000000000  # 1 GB
}

variable "network_in_alarm_description" {
  description = "Description for network in alarm (auto-generated if null)"
  type = string
  default = null
}

variable "network_in_alarm_actions" {
  description = "List of ARNs to notify when network in alarm triggers"
  type = list(string)
  default = []
}

variable "network_in_ok_actions" {
  description = "List of ARNs to notify when network in alarm returns to OK state"
  type = list(string)
  default = []
}

variable "network_in_insufficient_data_actions" {
  description = "List of ARNs to notify when network in alarm has insufficient data"
  type = list(string)
  default = []
}

variable "network_in_treat_missing_data" {
  description = "How to treat missing data for network in alarm"
  type = string
  default = null
}

variable "network_in_datapoints_to_alarm" {
  description = "Number of datapoints that must be breaching to trigger network in alarm"
  type = number
  default = null
}

variable "network_in_extended_statistic" {
  description = "Extended statistic for network in alarm"
  type = string
  default = null
}

variable "network_in_unit" {
  description = "Unit for network in alarm"
  type = string
  default = "Bytes"
}

variable "network_in_metric_name" {
  description = "Metric name for network in alarm"
  type = string
  default = "NetworkIn"
}

variable "network_in_namespace" {
  description = "Namespace for network in alarm"
  type = string
  default = "AWS/EC2"
}

variable "network_in_dimensions" {
  description = "Dimensions for network in alarm (auto-generated if null)"
  type = map(string)
  default = null
}

# =============================================================================
# NETWORK OUT ALARM VARIABLES
# =============================================================================

variable "create_network_out_alarm" {
  description = "Whether to create a network out alarm"
  type = bool
  default = false
}

variable "network_out_alarm_name" {
  description = "Name for the network out alarm (auto-generated if null)"
  type = string
  default = null
}

variable "network_out_comparison_operator" {
  description = "Comparison operator for network out alarm"
  type = string
  default = "GreaterThanThreshold"
}

variable "network_out_evaluation_periods" {
  description = "Number of evaluation periods for network out alarm"
  type = number
  default = 2
}

variable "network_out_period" {
  description = "Period in seconds for network out alarm"
  type = number
  default = 300
}

variable "network_out_statistic" {
  description = "Statistic for network out alarm"
  type = string
  default = "Average"
}

variable "network_out_threshold" {
  description = "Threshold in bytes for network out alarm"
  type = number
  default = 1000000000  # 1 GB
}

variable "network_out_alarm_description" {
  description = "Description for network out alarm (auto-generated if null)"
  type = string
  default = null
}

variable "network_out_alarm_actions" {
  description = "List of ARNs to notify when network out alarm triggers"
  type = list(string)
  default = []
}

variable "network_out_ok_actions" {
  description = "List of ARNs to notify when network out alarm returns to OK state"
  type = list(string)
  default = []
}

variable "network_out_insufficient_data_actions" {
  description = "List of ARNs to notify when network out alarm has insufficient data"
  type = list(string)
  default = []
}

variable "network_out_treat_missing_data" {
  description = "How to treat missing data for network out alarm"
  type = string
  default = null
}

variable "network_out_datapoints_to_alarm" {
  description = "Number of datapoints that must be breaching to trigger network out alarm"
  type = number
  default = null
}

variable "network_out_extended_statistic" {
  description = "Extended statistic for network out alarm"
  type = string
  default = null
}

variable "network_out_unit" {
  description = "Unit for network out alarm"
  type = string
  default = "Bytes"
}

variable "network_out_metric_name" {
  description = "Metric name for network out alarm"
  type = string
  default = "NetworkOut"
}

variable "network_out_namespace" {
  description = "Namespace for network out alarm"
  type = string
  default = "AWS/EC2"
}

variable "network_out_dimensions" {
  description = "Dimensions for network out alarm (auto-generated if null)"
  type = map(string)
  default = null
}

# =============================================================================
# STATUS CHECK ALARM VARIABLES
# =============================================================================

variable "create_status_check_alarm" {
  description = "Whether to create a status check failed alarm"
  type = bool
  default = true
}

variable "status_check_alarm_name" {
  description = "Name for the status check failed alarm (auto-generated if null)"
  type = string
  default = null
}

variable "status_check_comparison_operator" {
  description = "Comparison operator for status check alarm"
  type = string
  default = "GreaterThanThreshold"
}

variable "status_check_evaluation_periods" {
  description = "Number of evaluation periods for status check alarm"
  type = number
  default = 2
}

variable "status_check_period" {
  description = "Period in seconds for status check alarm"
  type = number
  default = 60
}

variable "status_check_statistic" {
  description = "Statistic for status check alarm"
  type = string
  default = "Maximum"
}

variable "status_check_threshold" {
  description = "Threshold for status check alarm"
  type = number
  default = 0
}

variable "status_check_alarm_description" {
  description = "Description for status check alarm (auto-generated if null)"
  type = string
  default = null
}

variable "status_check_alarm_actions" {
  description = "List of ARNs to notify when status check alarm triggers"
  type = list(string)
  default = []
}

variable "status_check_ok_actions" {
  description = "List of ARNs to notify when status check alarm returns to OK state"
  type = list(string)
  default = []
}

variable "status_check_insufficient_data_actions" {
  description = "List of ARNs to notify when status check alarm has insufficient data"
  type = list(string)
  default = []
}

variable "status_check_treat_missing_data" {
  description = "How to treat missing data for status check alarm"
  type = string
  default = null
}

variable "status_check_datapoints_to_alarm" {
  description = "Number of datapoints that must be breaching to trigger status check alarm"
  type = number
  default = null
}

variable "status_check_extended_statistic" {
  description = "Extended statistic for status check alarm"
  type = string
  default = null
}

variable "status_check_unit" {
  description = "Unit for status check alarm"
  type = string
  default = null
}

variable "status_check_metric_name" {
  description = "Metric name for status check alarm"
  type = string
  default = "StatusCheckFailed"
}

variable "status_check_namespace" {
  description = "Namespace for status check alarm"
  type = string
  default = "AWS/EC2"
}

variable "status_check_dimensions" {
  description = "Dimensions for status check alarm (auto-generated if null)"
  type = map(string)
  default = null
}

# =============================================================================
# DASHBOARD VARIABLES
# =============================================================================

variable "create_dashboard" {
  description = "Whether to create a CloudWatch dashboard"
  type = bool
  default = true
}

variable "dashboard_name" {
  description = "Name for the CloudWatch dashboard (auto-generated if null)"
  type = string
  default = null
}

variable "dashboard_body" {
  description = "Custom dashboard body JSON (auto-generated if null)"
  type = string
  default = null
}

variable "dashboard_period" {
  description = "Period for dashboard metrics"
  type = number
  default = 300
}

variable "dashboard_stat" {
  description = "Statistic for dashboard metrics"
  type = string
  default = "Average"
}

variable "dashboard_view" {
  description = "View type for dashboard widgets"
  type = string
  default = "timeSeries"
}

variable "dashboard_stacked" {
  description = "Whether to stack dashboard metrics"
  type = bool
  default = false
}

variable "dashboard_y_axis" {
  description = "Y-axis configuration for dashboard"
  type = map(any)
  default = null
}

variable "dashboard_cpu_metrics" {
  description = "Custom CPU metrics for dashboard (auto-generated if null)"
  type = list(list(string))
  default = null
}

variable "dashboard_system_metrics" {
  description = "Custom system metrics for dashboard (auto-generated if null)"
  type = list(list(string))
  default = null
}

variable "dashboard_cpu_title" {
  description = "Title for CPU metrics widget (auto-generated if null)"
  type = string
  default = null
}

variable "dashboard_system_title" {
  description = "Title for system metrics widget (auto-generated if null)"
  type = string
  default = null
}
