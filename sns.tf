#creating a SNS topic for LB connections
resource "aws_sns_topic" "sns-connections-lb" {
  name = "SNS-topic-lb"
}
#assigning email as subscription to the topic, email needs to be manually verified
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.sns-connections-lb.arn
  protocol = "email"
  endpoint = var.sns-email
}