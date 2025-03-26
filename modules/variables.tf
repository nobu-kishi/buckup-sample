variable "system_name" {
  description = "システム名"
  type        = string
}

variable "env" {
  description = "環境名"
  type        = string
}

variable "backup_name" {
  description = "バックアッププランに付与する一意な名称"
  type        = string
}

variable "schedule_cron" {
  description = "バックアップ頻度のcron設定"
  type        = string
}

variable "lifecycle_days" {
  description = "バックアップの保持期間"
  type        = string
}