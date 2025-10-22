variable "raw_bucket" {
  description = "The name of the raw S3 bucket"
  type        = string
}

variable "raw_bucket_arn" {
  description = "The ARN of the raw S3 bucket"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to be triggered"
  type        = string
}

