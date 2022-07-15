resource "aws_cloudwatch_metric_alarm" "lb-requests" {
  alarm_name          = "requests to ELB"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "RequestCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "20"
  alarm_description   = "Alarm if more than 20 connections per minute are issued towards the LB"
   actions_enabled     = true
  alarm_actions       = [aws_sns_topic.sns-connections-lb.arn]
  ok_actions          = [aws_sns_topic.sns-connections-lb.arn]
  dimensions = {
    LoadBalancer = aws_lb.staging-load-balancer.arn_suffix
    TargetGroup = aws_lb_target_group.instances.arn_suffix
  }
}
