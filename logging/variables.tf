# =============================================================================
# LOGGING MODULE VARIABLES
# =============================================================================

variable "instance_name" {
  description = "Name of the EC2 instance for log group and stream naming"
  type = string
}

variable "tags" {
  description = "Tags to apply to all logging resources"
  type = map(string)
  default = {}
}

# =============================================================================
# APPLICATION LOG GROUP VARIABLES
# =============================================================================

variable "create_application_log_group" {
  description = "Whether to create a CloudWatch log group for application logs"
  type = bool
  default = false
}

variable "application_log_group_name" {
  description = "Name for the application log group (auto-generated if null)"
  type = string
  default = null
}

variable "application_log_retention_days" {
  description = "Retention period in days for application logs"
  type = number
  default = 30
}

variable "application_log_group_kms_key_id" {
  description = "KMS key ID for application log group encryption"
  type = string
  default = null
}

variable "application_log_group_skip_destroy" {
  description = "Whether to skip destroying the application log group"
  type = bool
  default = false
}

variable "create_application_log_stream" {
  description = "Whether to create a log stream for application logs"
  type = bool
  default = false
}

variable "application_log_stream_name" {
  description = "Name for the application log stream (auto-generated if null)"
  type = string
  default = null
}

# =============================================================================
# SYSTEM LOG GROUP VARIABLES
# =============================================================================

variable "create_system_log_group" {
  description = "Whether to create a CloudWatch log group for system logs"
  type = bool
  default = false
}

variable "system_log_group_name" {
  description = "Name for the system log group (auto-generated if null)"
  type = string
  default = null
}

variable "system_log_retention_days" {
  description = "Retention period in days for system logs"
  type = number
  default = 30
}

variable "system_log_group_kms_key_id" {
  description = "KMS key ID for system log group encryption"
  type = string
  default = null
}

variable "system_log_group_skip_destroy" {
  description = "Whether to skip destroying the system log group"
  type = bool
  default = false
}

variable "create_system_log_stream" {
  description = "Whether to create a log stream for system logs"
  type = bool
  default = false
}

variable "system_log_stream_name" {
  description = "Name for the system log stream (auto-generated if null)"
  type = string
  default = null
}

# =============================================================================
# ACCESS LOG GROUP VARIABLES
# =============================================================================

variable "create_access_log_group" {
  description = "Whether to create a CloudWatch log group for access logs"
  type = bool
  default = false
}

variable "access_log_group_name" {
  description = "Name for the access log group (auto-generated if null)"
  type = string
  default = null
}

variable "access_log_retention_days" {
  description = "Retention period in days for access logs"
  type = number
  default = 30
}

variable "access_log_group_kms_key_id" {
  description = "KMS key ID for access log group encryption"
  type = string
  default = null
}

variable "access_log_group_skip_destroy" {
  description = "Whether to skip destroying the access log group"
  type = bool
  default = false
}

variable "create_access_log_stream" {
  description = "Whether to create a log stream for access logs"
  type = bool
  default = false
}

variable "access_log_stream_name" {
  description = "Name for the access log stream (auto-generated if null)"
  type = string
  default = null
}

# =============================================================================
# ERROR LOG GROUP VARIABLES
# =============================================================================

variable "create_error_log_group" {
  description = "Whether to create a CloudWatch log group for error logs"
  type = bool
  default = false
}

variable "error_log_group_name" {
  description = "Name for the error log group (auto-generated if null)"
  type = string
  default = null
}

variable "error_log_retention_days" {
  description = "Retention period in days for error logs"
  type = number
  default = 90
}

variable "error_log_group_kms_key_id" {
  description = "KMS key ID for error log group encryption"
  type = string
  default = null
}

variable "error_log_group_skip_destroy" {
  description = "Whether to skip destroying the error log group"
  type = bool
  default = false
}

variable "create_error_log_stream" {
  description = "Whether to create a log stream for error logs"
  type = bool
  default = false
}

variable "error_log_stream_name" {
  description = "Name for the error log stream (auto-generated if null)"
  type = string
  default = null
}

# =============================================================================
# CUSTOM LOG GROUP VARIABLES
# =============================================================================

variable "custom_log_groups" {
  description = "Map of custom log groups to create"
  type = map(object({
    name = optional(string)
    retention_days = optional(number)
    kms_key_id = optional(string)
    skip_destroy = optional(bool)
    tags = optional(map(string))
  }))
  default = {}
}

variable "default_custom_log_retention_days" {
  description = "Default retention period in days for custom log groups"
  type = number
  default = 30
}

variable "default_custom_log_skip_destroy" {
  description = "Default skip destroy setting for custom log groups"
  type = bool
  default = false
}

variable "custom_log_streams" {
  description = "Map of custom log streams to create"
  type = map(object({
    name = optional(string)
    log_group_key = string
  }))
  default = {}
}

# =============================================================================
# METRIC FILTER VARIABLES
# =============================================================================

variable "create_error_metric_filter" {
  description = "Whether to create a metric filter for error logs"
  type = bool
  default = false
}

variable "error_metric_filter_name" {
  description = "Name for the error metric filter (auto-generated if null)"
  type = string
  default = null
}

variable "error_metric_filter_pattern" {
  description = "Filter pattern for error logs"
  type = string
  default = "[timestamp, level=ERROR, message]"
}

variable "error_metric_name" {
  description = "Name for the error metric (auto-generated if null)"
  type = string
  default = null
}

variable "error_metric_namespace" {
  description = "Namespace for the error metric"
  type = string
  default = null
}

variable "error_metric_value" {
  description = "Value to increment for each error log entry"
  type = string
  default = "1"
}

variable "error_metric_default_value" {
  description = "Default value for the error metric"
  type = string
  default = "0"
}

variable "create_access_metric_filter" {
  description = "Whether to create a metric filter for access logs"
  type = bool
  default = false
}

variable "access_metric_filter_name" {
  description = "Name for the access metric filter (auto-generated if null)"
  type = string
  default = null
}

variable "access_metric_filter_pattern" {
  description = "Filter pattern for access logs"
  type = string
  default = "[timestamp, ip, method, path, status]"
}

variable "access_metric_name" {
  description = "Name for the access metric (auto-generated if null)"
  type = string
  default = null
}

variable "access_metric_namespace" {
  description = "Namespace for the access metric"
  type = string
  default = null
}

variable "access_metric_value" {
  description = "Value to increment for each access log entry"
  type = string
  default = "1"
}

variable "access_metric_default_value" {
  description = "Default value for the access metric"
  type = string
  default = "0"
}

variable "custom_metric_filters" {
  description = "Map of custom metric filters to create"
  type = map(object({
    name = optional(string)
    pattern = string
    log_group_key = string
    metric_name = optional(string)
    metric_namespace = optional(string)
    metric_value = optional(string)
    metric_default_value = optional(string)
  }))
  default = {}
}

# =============================================================================
# LOG ALARM VARIABLES
# =============================================================================

variable "create_error_log_alarm" {
  description = "Whether to create an alarm for error log rate"
  type = bool
  default = false
}

variable "error_log_alarm_name" {
  description = "Name for the error log alarm (auto-generated if null)"
  type = string
  default = null
}

variable "error_log_alarm_comparison_operator" {
  description = "Comparison operator for error log alarm"
  type = string
  default = "GreaterThanThreshold"
}

variable "error_log_alarm_evaluation_periods" {
  description = "Number of evaluation periods for error log alarm"
  type = number
  default = 2
}

variable "error_log_alarm_period" {
  description = "Period in seconds for error log alarm"
  type = number
  default = 300
}

variable "error_log_alarm_statistic" {
  description = "Statistic for error log alarm"
  type = string
  default = "Sum"
}

variable "error_log_alarm_threshold" {
  description = "Threshold for error log alarm"
  type = number
  default = 10
}

variable "error_log_alarm_description" {
  description = "Description for error log alarm (auto-generated if null)"
  type = string
  default = null
}

variable "error_log_alarm_actions" {
  description = "List of ARNs to notify when error log alarm triggers"
  type = list(string)
  default = []
}

variable "error_log_alarm_ok_actions" {
  description = "List of ARNs to notify when error log alarm returns to OK state"
  type = list(string)
  default = []
}

variable "error_log_alarm_treat_missing_data" {
  description = "How to treat missing data for error log alarm"
  type = string
  default = "notBreaching"
}

variable "create_access_log_alarm" {
  description = "Whether to create an alarm for access log rate"
  type = bool
  default = false
}

variable "access_log_alarm_name" {
  description = "Name for the access log alarm (auto-generated if null)"
  type = string
  default = null
}

variable "access_log_alarm_comparison_operator" {
  description = "Comparison operator for access log alarm"
  type = string
  default = "GreaterThanThreshold"
}

variable "access_log_alarm_evaluation_periods" {
  description = "Number of evaluation periods for access log alarm"
  type = number
  default = 2
}

variable "access_log_alarm_period" {
  description = "Period in seconds for access log alarm"
  type = number
  default = 300
}

variable "access_log_alarm_statistic" {
  description = "Statistic for access log alarm"
  type = string
  default = "Sum"
}

variable "access_log_alarm_threshold" {
  description = "Threshold for access log alarm"
  type = number
  default = 1000
}

variable "access_log_alarm_description" {
  description = "Description for access log alarm (auto-generated if null)"
  type = string
  default = null
}

variable "access_log_alarm_actions" {
  description = "List of ARNs to notify when access log alarm triggers"
  type = list(string)
  default = []
}

variable "access_log_alarm_ok_actions" {
  description = "List of ARNs to notify when access log alarm returns to OK state"
  type = list(string)
  default = []
}

variable "access_log_alarm_treat_missing_data" {
  description = "How to treat missing data for access log alarm"
  type = string
  default = "notBreaching"
}

variable "custom_log_alarms" {
  description = "Map of custom log alarms to create"
  type = map(object({
    alarm_name = optional(string)
    comparison_operator = string
    evaluation_periods = number
    period = number
    statistic = string
    threshold = number
    alarm_description = optional(string)
    alarm_actions = optional(list(string))
    ok_actions = optional(list(string))
    treat_missing_data = optional(string)
    metric_name = optional(string)
    metric_namespace = optional(string)
    tags = optional(map(string))
  }))
  default = {}
}
