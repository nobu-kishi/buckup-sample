system_name = "sample"
env         = "dev"

sns_protocol = "email"               # or "sms"
sns_endpoint = "example@example.com" # or "09012345678"

backup_config_list = [
  {
    backup_name    = "lifecycle-daily-35day"
    lifecycle_days = 35
    schedule_cron  = "cron(0 20 * * ? *)"
  }
]