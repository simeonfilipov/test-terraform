resource "aws_sns_topic" "sns-connections-lb" {
  name = "SNS-topic-lb"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.sns-connections-lb.arn
  protocol = "email"
  endpoint = var.sns-email
}