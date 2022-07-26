
########################################################## CONFIGURATION #############################################################


resource "newrelic_alert_channel" "ops_engine" {
  count = var.ops_engine_integration == true ? 1 : 0
  name  = "${var.trybe_name}-ops-engine"
  type  = "opsgenie"

  config {
    api_key = var.ops_engine_api_key
    region  = var.ops_engine_region
  }
}


resource "newrelic_alert_channel" "slack_channel" {
  count = var.ops_engine_integration == false ? 1 : 0
  name  = "${var.trybe_name}-slack"
  type  = "slack"

  config {
    url     = var.url_slack
    channel = var.channel_slack
  }
}



resource "newrelic_alert_policy" "ops_engine_channels" {
  count               = var.ops_engine_integration == true ? 1 : 0
  name                = var.alert_policy_name
  incident_preference = "PER_CONDITION"
  

  channel_ids = [newrelic_alert_channel.ops_engine[0].id]
}

resource "newrelic_alert_policy" "slack_channels" {
  count               = var.ops_engine_integration == false ? 1 : 0
  name                = var.alert_policy_name
  incident_preference = "PER_CONDITION"
  

  channel_ids = [newrelic_alert_channel.slack_channel[0].id]
}






############################################################## RELACTIONAL DATABASE PROCESS #############################################


resource "newrelic_nrql_alert_condition" "database_lock" {
  count                          = var.operator != "" && var.relactional_database == true ? 1 : 0
  policy_id                      = var.ops_engine_integration == true ? newrelic_alert_policy.ops_engine_channels[0].id : newrelic_alert_policy.slack_channels[0].id
  type                           = "static"
  name                           = "DeadLock Database ${var.relactional_database_name}"
  description                    = "DeadLock Database ${var.relactional_database_name}"
  enabled                        = var.enabled
  violation_time_limit_seconds   = var.violation_time_limit_seconds
  expiration_duration            = var.expiration_duration
  close_violations_on_expiration = var.close_violations_on_expiration
  aggregation_window             = var.aggregation_window

  nrql {
    query = join(" ", [var.query_deadlock, var.relactional_database_name])
  }

  critical {
    operator              = var.operator
    threshold             = var.threshold_cpu_deadlock
    threshold_duration    = var.threshold_cpu_deadlock_duration
    threshold_occurrences = "AT_LEAST_ONCE"
  }

}

resource "newrelic_nrql_alert_condition" "database_lock_equal" {

  count                          = var.operator == "" && var.relactional_database == true ? 1 : 0
  policy_id                      = var.ops_engine_integration == true ? newrelic_alert_policy.ops_engine_channels[0].id : newrelic_alert_policy.slack_channels[0].id
  type                           = "static"
  name                           = "DeadLock Database ${var.relactional_database_name}"
  description                    = "DeadLock Database ${var.relactional_database_name}"
  enabled                        = var.enabled
  violation_time_limit_seconds   = var.violation_time_limit_seconds
  expiration_duration            = var.expiration_duration
  close_violations_on_expiration = var.close_violations_on_expiration
  aggregation_window             = var.aggregation_window

  nrql {
    query = join(" ", [var.query_deadlock, var.relactional_database_name])
  }

  critical {
    threshold             = var.threshold_cpu_deadlock
    threshold_duration    = var.threshold_cpu_deadlock_duration
    threshold_occurrences = "AT_LEAST_ONCE"
  }

}


resource "newrelic_nrql_alert_condition" "database_connection" {
  count                          = var.operator != "" && var.relactional_database == true ? 1 : 0
  policy_id                      = var.ops_engine_integration == true ? newrelic_alert_policy.ops_engine_channels[0].id : newrelic_alert_policy.slack_channels[0].id
  type                           = "static"
  name                           = "Connection Database ${var.relactional_database_name}"
  description                    = "Connection Database ${var.relactional_database_name}"
  enabled                        = var.enabled
  violation_time_limit_seconds   = var.violation_time_limit_seconds
  expiration_duration            = var.expiration_duration
  close_violations_on_expiration = var.close_violations_on_expiration
  aggregation_window             = var.aggregation_window

  nrql {
    query = join(" ", [var.query_how_many_connection, var.relactional_database_name])
  }

  critical {
    operator              = var.operator
    threshold             = var.threshold_cpu_connection
    threshold_duration    = var.threshold_cpu_connection_duration
    threshold_occurrences = "AT_LEAST_ONCE"
  }

}

resource "newrelic_nrql_alert_condition" "database_connection_equal" {

  count                          = var.operator == "" && var.relactional_database == true ? 1 : 0
  policy_id                      = var.ops_engine_integration == true ? newrelic_alert_policy.ops_engine_channels[0].id : newrelic_alert_policy.slack_channels[0].id
  type                           = "static"
  name                           = "Connection Database ${var.relactional_database_name}"
  description                    = "Connection Database ${var.relactional_database_name}"
  enabled                        = var.enabled
  violation_time_limit_seconds   = var.violation_time_limit_seconds
  expiration_duration            = var.expiration_duration
  close_violations_on_expiration = var.close_violations_on_expiration
  aggregation_window             = var.aggregation_window

  nrql {
    query = join(" ", [var.query_how_many_connection, var.relactional_database_name])
  }

  critical {
    threshold             = var.threshold_cpu_connection
    threshold_duration    = var.threshold_cpu_connection_duration
    threshold_occurrences = "AT_LEAST_ONCE"
  }

}

########################################################## RELACTIONAL DATABASE CPU ####################################################



resource "newrelic_nrql_alert_condition" "cpu_percentage" {
  count                          = var.operator != "" && var.relactional_database == true ? 1 : 0
  policy_id                      = var.ops_engine_integration == true ? newrelic_alert_policy.ops_engine_channels[0].id : newrelic_alert_policy.slack_channels[0].id
  type                           = "static"
  name                           = "CPU Database Percentage ${var.relactional_database_name}"
  description                    = "CPU Database Percentage ${var.relactional_database_name}"
  enabled                        = var.enabled
  violation_time_limit_seconds   = var.violation_time_limit_seconds
  expiration_duration            = var.expiration_duration
  close_violations_on_expiration = var.close_violations_on_expiration
  aggregation_window             = var.aggregation_window

  nrql {
    query = join(" ", [var.query_cpu_percentage, var.relactional_database_name])

  }

  critical {
    operator              = var.operator
    threshold             = var.threshold_cpu
    threshold_duration    = var.threshold_cpu_duration
    threshold_occurrences = "ALL"
  }

}

resource "newrelic_nrql_alert_condition" "cpu_peak_percentage" {
  count                          = var.operator == "" && var.relactional_database == true ? 1 : 0
  policy_id                      = var.ops_engine_integration == true ? newrelic_alert_policy.ops_engine_channels[0].id : newrelic_alert_policy.slack_channels[0].id
  type                           = "static"
  name                           = "CPU Database Percentage Peak ${var.relactional_database_name}"
  description                    = "CPU Database Percentage Peak ${var.relactional_database_name}"
  enabled                        = var.enabled
  violation_time_limit_seconds   = var.violation_time_limit_seconds
  expiration_duration            = var.expiration_duration
  close_violations_on_expiration = var.close_violations_on_expiration
  aggregation_window             = var.aggregation_window

  nrql {
    query = join(" ", [var.query_peak_cpu_percentage, var.relactional_database_name])
  }

  critical {
    threshold             = var.threshold_cpu_peak
    threshold_duration    = var.threshold_cpu_peak_duration
    threshold_occurrences = "AT_LEAST_ONCE"
  }

}

resource "newrelic_nrql_alert_condition" "cpu_percentage_equal" {

  count                          = var.operator == "" && var.relactional_database == true ? 1 : 0
  policy_id                      = var.ops_engine_integration == true ? newrelic_alert_policy.ops_engine_channels[0].id : newrelic_alert_policy.slack_channels[0].id
  type                           = "static"
  name                           = "CPU Database Percentage ${var.relactional_database_name}"
  description                    = "CPU Database Percentage ${var.relactional_database_name}"
  enabled                        = var.enabled
  violation_time_limit_seconds   = var.violation_time_limit_seconds
  expiration_duration            = var.expiration_duration
  close_violations_on_expiration = var.close_violations_on_expiration
  aggregation_window             = var.aggregation_window

  nrql {
    query = join(" ", [var.query_cpu_percentage, var.relactional_database_name])
  }

  critical {
    threshold             = var.threshold_cpu
    threshold_duration    = var.threshold_cpu_duration
    threshold_occurrences = "ALL"
  }

}

