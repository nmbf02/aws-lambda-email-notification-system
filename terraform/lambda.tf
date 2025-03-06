resource "aws_lambda_function" "send_email_lambda" {
  function_name = "send_email_function"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "send_email.lambda_handler"
  runtime       = "python3.9"

  s3_bucket = aws_s3_bucket.lambda_code_bucket.bucket
  s3_key    = "send_email.zip"

  environment {
    variables = {
      SMTP_SERVER   = "smtp.gmail.com"
      SMTP_PORT     = "587"
      SMTP_USER     = "nathalyberroaf@gmail.com"
      SMTP_PASSWORD = "wybw lfhb kahh rvtg"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_policy_attachment
  ]
}

# Asociar la cola SQS con la función Lambda
resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  event_source_arn = aws_sqs_queue.notification_queue.arn
  function_name    = aws_lambda_function.send_email_lambda.arn
  batch_size       = 10

  depends_on = [
    aws_lambda_function.send_email_lambda
  ]
}
