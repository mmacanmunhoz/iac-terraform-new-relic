module "relational_databases_alerts" {
   source                = "./modules/relational-databases"

   # Configuration
   ops_engine_integration         = true  // false to slack integration
   relactional_database_name      = "'prd-dam-1'"
   alert_policy_name              = "avaliacoes"
   trybe_name                     = "avaliacoes"

   # Slack
   channel_slack                  = ""    // only if ops_engine_integration is false
   url_slack                      = ""    // only if ops_engine_integration is false


   relactional_database           = true

   # Properties
   operator                       = ""    // empty is equal, change value for above or below
   threshold_cpu                  = 70    // porcentage
   threshold_cpu_peak             = 90
   threshold_cpu_deadlock         = 15
   threshold_cpu_connection       = 30

   # Duration
   threshold_cpu_connection_duration = 900
   threshold_cpu_deadlock_duration = 900
   threshold_cpu_peak_duration = 900
   threshold_cpu_duration = 900

 }




