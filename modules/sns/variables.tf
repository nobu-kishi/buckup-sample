variable "system_name" {
  description = "システム名"
  type        = string
}

variable "env" {
  description = "環境名"
  type        = string
}

variable "sns_protocol" {
  description = "通知プロトコル（email または sms）"
  type        = string
}

variable "sns_endpoint" {
  description = "通知先エンドポイント（メールアドレスまたは電話番号）"
  type        = string
}
