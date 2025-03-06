variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "aws-lambda-email-notification-system"
}

variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-2"
}

variable "lambda_bucket_name" {
  description = "Nombre del bucket S3 para almacenar la función Lambda"
  type        = string
  default     = "lambda-function-code-bucket-unique1234"
}