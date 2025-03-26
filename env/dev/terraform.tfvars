### 基本情報
# aws_region = "ap-northeast-1"
system_name = "sample"
env         = "dev"

# backup_name = "daily-35day-retention"
backup_config_list = [
  {
    backup_name    = "lifecycle-daily-35day"
    lifecycle_days = 35
    schedule_cron  = "cron(0 20 * * ? *)" # TODO: 仮設定
    # backup_resouce_list = ["ec2", "efs", "aurora", "s3"]
  }
]