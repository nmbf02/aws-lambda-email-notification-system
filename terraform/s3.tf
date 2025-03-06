# Crear un bucket S3 para almacenar el código de la función Lambda
resource "aws_s3_bucket" "lambda_code_bucket" {
  bucket = var.lambda_bucket_name

  tags = {
    Name = "Bucket para código Lambda"
  }
}