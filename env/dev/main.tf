
module "sns" {
  source       = "../../modules/sns"
  system_name  = var.system_name
  env          = var.env
  sns_protocol = var.sns_protocol
  sns_endpoint = var.sns_endpoint
}

module "backup" {
  source         = "../../modules/backup"
  for_each       = { for i in var.backup_config_list : i.backup_name => i }
  backup_name    = each.value.backup_name
  schedule_cron  = each.value.schedule_cron
  lifecycle_days = each.value.lifecycle_days

  system_name   = var.system_name
  env           = var.env
  sns_topic_arn = module.sns.alert_topic_arn
}