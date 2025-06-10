output "alert_topic_arn" {
  description = "SNSトピックのARN"
  value       = aws_sns_topic.this.arn
}