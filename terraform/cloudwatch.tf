# Alarma para Errores en la Función Lambda
resource "aws_cloudwatch_metric_alarm" "lambda_error_alarm" {
  alarm_name          = "LambdaErrorAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 60
  statistic           = "Sum"
  threshold           = 1

  dimensions = {
    FunctionName = aws_lambda_function.send_email_lambda.function_name
  }

  alarm_description = "Alarma cuando la función Lambda genera errores."
  alarm_actions     = [aws_sns_topic.notification_topic.arn]
}

# Alarma para la Longitud de la Cola SQS
resource "aws_cloudwatch_metric_alarm" "sqs_queue_length_alarm" {
  alarm_name          = "SQSQueueLengthAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 60
  statistic           = "Average"
  threshold           = 5

  dimensions = {
    QueueName = aws_sqs_queue.notification_queue.name
  }

  alarm_description = "Alarma cuando la longitud de la cola SQS es mayor a 5 mensajes."
  alarm_actions     = [aws_sns_topic.notification_topic.arn]
}
