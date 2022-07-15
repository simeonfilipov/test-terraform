#definition of alarm for Cloudwatch if ELB is receiving more than 20 requests per minute
resource "aws_cloudwatch_metric_alarm" "lb-requests" {
  alarm_name          = "requests to ELB"
  comparison_operator = "GreaterThanThreshold" //compare to threshold value
  evaluation_periods  = "1"
  metric_name         = "RequestCount" //what option to monitor
  namespace           = "AWS/ApplicationELB"
  period              = "60" //1 minute
  statistic           = "Sum" //sum of the values of the all data points collected during the period
  threshold           = "20" //defining the threshold
  alarm_description   = "Alarm if more than 20 connections per minute are issued towards the LB"
   actions_enabled     = true
  alarm_actions       = [aws_sns_topic.sns-connections-lb.arn]
  ok_actions          = [aws_sns_topic.sns-connections-lb.arn]
  #choosing the LB target group to monitor and ALB using arn suffix
  dimensions = {
    LoadBalancer = aws_lb.staging-load-balancer.arn_suffix
    TargetGroup = aws_lb_target_group.instances.arn_suffix
  }
}
