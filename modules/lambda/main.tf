resource "aws_lambda_function" "data_handler" {
  function_name = "${var.project_prefix}-data-handler"
  role          = var.lambda_role_arn
  handler       = "index.lambda_handler"
  runtime       = "python3.12"

  # Pointed to the zip file in the root folder
  filename      = "${path.root}/lambda_code/lambda.zip"

  environment {
    variables = {
      RAW_BUCKET       = var.raw_bucket
      PROCESSED_BUCKET = var.processed_bucket
    }
  }
}
#