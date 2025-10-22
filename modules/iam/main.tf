###########################################

# IAM Role for Lambda

###########################################

resource "aws_iam_role" "lambda_role" {
name = "Lambda-S3-Glue-Role"

assume_role_policy = jsonencode({
Version = "2012-10-17"
Statement = [
{
Effect = "Allow"
Principal = {
Service = "lambda.amazonaws.com"
}
Action = "sts:AssumeRole"
}
]
})
}

# Attach policies to Lambda role

resource "aws_iam_role_policy_attachment" "lambda_s3_access" {
role       = aws_iam_role.lambda_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_glue_access" {
role       = aws_iam_role.lambda_role.name
policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
role       = aws_iam_role.lambda_role.name
policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

###########################################

# IAM Role for Glue

###########################################

resource "aws_iam_role" "glue_role" {
name = "Glue-Service-Role"

assume_role_policy = jsonencode({
Version = "2012-10-17"
Statement = [
{
Effect = "Allow"
Principal = {
Service = "glue.amazonaws.com"
}
Action = "sts:AssumeRole"
}
]
})
}

# Attach policies to Glue role

resource "aws_iam_role_policy_attachment" "glue_s3_access" {
role       = aws_iam_role.glue_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "glue_service_access" {
role       = aws_iam_role.glue_role.name
policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

############################################