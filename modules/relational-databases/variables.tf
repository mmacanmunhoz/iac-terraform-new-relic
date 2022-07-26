variable "account_id" {
    type = string
    default = ""
}


variable "api_key" {
    type = string
    default = ""
}

variable "region" {
    type = string
    default = "US"
}


variable "threshold_cpu" {
    type = number
}

variable "threshold_cpu_peak" {
    type = number
}

variable "threshold_cpu_deadlock" {
    type = number
}

variable "threshold_cpu_connection" {
    type = number
}

variable "threshold_cpu_connection_duration" {
    type = number
}

variable "threshold_cpu_deadlock_duration" {
    type = number
}

variable "threshold_cpu_peak_duration" {
    type = number
}

variable "threshold_cpu_duration" {
    type = number
}

variable "operator" {
  type    = string
  default = ""
}

variable "query_deadlock" {
  type    = string
  default = "SELECT max(`aws.rds.Deadlocks`) FROM Metric FACET `aws.rds.DBInstanceIdentifier` where aws.rds.DBInstanceIdentifier = "
}

variable "query_how_many_connection" {
  type    = string
  default = "SELECT max(`aws.rds.DatabaseConnections`) FROM Metric FACET `aws.rds.DBInstanceIdentifier` WHERE aws.rds.DBInstanceIdentifier = "
}

variable "query_cpu_percentage" {
  type    = string
  default = "SELECT average(`aws.rds.CPUUtilization`) FROM Metric FACET `aws.rds.DBInstanceIdentifier` WHERE aws.rds.DBInstanceIdentifier = "
}

variable "query_peak_cpu_percentage" {
  type    = string
  default = "SELECT max(`aws.rds.CPUUtilization`) FROM Metric FACET `aws.rds.DBInstanceIdentifier` where  aws.rds.DBInstanceIdentifier = "
}


variable "alert_policy_name" {
  type = string
}

variable "relactional_database_name" {
  type    = string
  default = ""
}

variable "ops_engine_integration" {
  type    = bool
  default = false
}

variable "relactional_database" {
  type    = bool
  default = true
}

variable "trybe_name" {
  type    = string
  default = ""
}

variable "url_slack" {
  type    = string
  default = ""
}

variable "channel_slack" {
  type    = string
  default = ""
}

variable "ops_engine_api_key" {
  type    = string
  default = ""
}

variable "ops_engine_region" {
  type    = string
  default = "US"
}

variable "violation_time_limit_seconds" {
  type    = number
  default = 86400
}

variable "expiration_duration" {
  type    = number
  default = 300
}


variable "close_violations_on_expiration" {
  type    = bool
  default = true
}


variable "aggregation_window" {
  type    = number
  default = 60
}

variable "enabled" {
  type    = bool
  default = true
}