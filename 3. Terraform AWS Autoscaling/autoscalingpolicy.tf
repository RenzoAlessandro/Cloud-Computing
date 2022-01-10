#  --------------------------------------------------------------------------------------------------------------------
#  1. CREACIÓN DE POLITICAS DE ESCALADO DINÁMICO
#  --------------------------------------------------------------------------------------------------------------------

# Scaling OUT
resource "aws_autoscaling_policy" "example-cpu-policy" {
  name                   = "cpu-policy-scale-Out"
  autoscaling_group_name = "${aws_autoscaling_group.my-centos-ucsp-ec2.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

#  --------------------------------------------------------------------------------------------------------------------
#  2. CREACIÓN DE ALARMA DE CLOUDWATCH - OUT
#  --------------------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm" {
  alarm_name          = "cpu-alarm-OUT"
  alarm_description   = "cpu-alarm-OUT"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "50"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.my-centos-ucsp-ec2.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.example-cpu-policy.arn}"]
}

# Scaling IN
resource "aws_autoscaling_policy" "example-cpu-policy-scaledown" {
  name                   = "cpu-policy-scale-In"
  autoscaling_group_name = "${aws_autoscaling_group.my-centos-ucsp-ec2.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

#  --------------------------------------------------------------------------------------------------------------------
#  2. CREACIÓN DE ALARMA DE CLOUDWATCH - IN
#  --------------------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm-scaledown" {
  alarm_name          = "cpu-alarm-IN"
  alarm_description   = "cpu-alarm-IN"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "40"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.my-centos-ucsp-ec2.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.example-cpu-policy-scaledown.arn}"]
}