#--------------------------------------------------------------
# SNS
#--------------------------------------------------------------
resource "aws_sns_topic" "this" {
  name = local.SNS_ALERT_TOPIC
}

resource "aws_sns_topic_policy" "bk_topic_policy" {
  arn    = aws_sns_topic.this.arn
  policy = data.aws_iam_policy_document.bk_topic_policy.json
}

data "aws_iam_policy_document" "bk_topic_policy" {
  statement {
    actions = ["SNS:Publish"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
    resources = [aws_sns_topic.this.arn]
  }
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = var.sns_protocol
  endpoint  = var.sns_endpoint
}