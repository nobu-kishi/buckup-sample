locals {
  NAME_PREFIX     = format("%s-%s", var.system_name, var.env)
  SNS_ALERT_TOPIC = format("%s-alert-topic", local.NAME_PREFIX)
}