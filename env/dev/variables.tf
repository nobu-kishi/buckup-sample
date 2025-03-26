variable "system_name" {
  description = "システム名"
  type        = string
}

variable "env" {
  description = "環境名"
  type        = string
}

variable "backup_config_list" {
  description = "バックアップの設定情報"
  type = list(object({
    backup_name           = string
    schedule_cron         = string
    lifecycle_days        = number
    # backup_resouce_type_list = list(string)
  }))
}

