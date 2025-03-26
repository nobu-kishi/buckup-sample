module "backup" {
  source = "../../modules"
  for_each = { for i in var.backup_config_list : i.backup_name => i }

  backup_name    = each.value.backup_name
  schedule_cron  = each.value.schedule_cron
  lifecycle_days = each.value.lifecycle_days

  system_name = var.system_name
  env         = var.env
}