# Crear un tópico SNS para distribuir mensajes
resource "aws_sns_topic" "notification_topic" {
  name = "${var.project_name}_sns_topic"
}

# Crear una cola SQS que reciba mensajes del SNS
resource "aws_sqs_queue" "notification_queue" {
  name = "${var.project_name}_sqs_queue"
}

# Configurar la suscripción de SQS al SNS
resource "aws_sns_topic_subscription" "sns_to_sqs" {
  topic_arn = aws_sns_topic.notification_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.notification_queue.arn

  depends_on = [aws_sqs_queue.notification_queue]
}