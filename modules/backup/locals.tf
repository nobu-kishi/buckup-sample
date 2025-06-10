locals {
  NAME_PREFIX           = format("%s-%s", var.system_name, var.env)
  BACKUP_ROLE_NAME      = format("%s-iam-role-backup-execution", local.NAME_PREFIX)
  BACKUP_PLAN_NAME      = format("%s-infra", local.NAME_PREFIX)
  BACKUP_RULE_NAME      = format("%s", var.backup_name)
  BACKUP_VAULT_NAME     = format("%s-vault-infra", local.NAME_PREFIX)
  BACKUP_SELECTION_NAME = format("%s-infra", local.NAME_PREFIX)
}