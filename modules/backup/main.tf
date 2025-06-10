#--------------------------------------------------------------
# AWS Backup
#--------------------------------------------------------------
resource "aws_backup_vault" "this" {
  name = local.BACKUP_VAULT_NAME
}

resource "aws_backup_plan" "this" {
  name = local.BACKUP_PLAN_NAME

  # NOTE: Vaultをリソース毎などの単位で分ける場合、ルールを複数作成する
  rule {
    rule_name         = local.BACKUP_RULE_NAME
    target_vault_name = aws_backup_vault.this.name
    schedule          = var.schedule_cron

    lifecycle {
      # NOTE: データの保持期間
      delete_after = var.lifecycle_days
    }
  }
}

resource "aws_backup_selection" "this" {
  iam_role_arn = aws_iam_role.bk_role.arn
  name         = local.BACKUP_SELECTION_NAME
  plan_id      = aws_backup_plan.this.id

  # NOTE: システム名で決め打ちしているので、タグ付けルールによって適宜調整すること
  selection_tag {
    type  = "STRINGEQUALS"
    key   = "System-Name"
    value = var.system_name
  }
}

resource "aws_backup_vault_notifications" "this" {
  backup_vault_name = aws_backup_vault.this.name
  sns_topic_arn     = var.sns_topic_arn

  backup_vault_events = [
    "BACKUP_JOB_FAILED",
    "RESTORE_JOB_FAILED"
  ]
}

#--------------------------------------------------------------
# IAM ロール
#--------------------------------------------------------------
resource "aws_iam_role" "bk_role" {
  name               = local.BACKUP_ROLE_NAME
  assume_role_policy = data.aws_iam_policy_document.bk.json
}

data "aws_iam_policy_document" "bk" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}

# バックアップのポリシーを追加
data "aws_iam_policy" "bk" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "bk" {
  role       = aws_iam_role.bk_role.name
  policy_arn = data.aws_iam_policy.bk.arn
}

# バックアップのリストアポリシーを追加
data "aws_iam_policy" "bk_restore" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

resource "aws_iam_role_policy_attachment" "bk_restore" {
  role       = aws_iam_role.bk_role.name
  policy_arn = data.aws_iam_policy.bk_restore.arn
}

# バックアップのポリシーを追加（S3）
data "aws_iam_policy" "s3_bk" {
  arn = "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Backup"
}

resource "aws_iam_role_policy_attachment" "s3_bk" {
  role       = aws_iam_role.bk_role.name
  policy_arn = data.aws_iam_policy.s3_bk.arn
}

# バックアップのリストアポリシーを追加（S3）
data "aws_iam_policy" "s3_bk_restore" {
  arn = "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Restore"
}

resource "aws_iam_role_policy_attachment" "s3_bk_restore" {
  role       = aws_iam_role.bk_role.name
  policy_arn = data.aws_iam_policy.s3_bk_restore.arn
}