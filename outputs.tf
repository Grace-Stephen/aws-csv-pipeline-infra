# root/outputs.tf

# --- S3 Buckets ---
output "bucket_names" {
  description = "Names of the created S3 buckets"
  value = [
    module.S3.raw_bucket_name,
    module.S3.processed_bucket_name,
    module.S3.final_bucket_name
  ]
}

output "bucket_arns" {
  value = [
    module.S3.raw_bucket_arn,
    module.S3.processed_bucket_arn,
    module.S3.final_bucket_arn
  ]
}


# --- IAM Roles ---
output "lambda_role_arn" {
  description = "ARN of the Lambda IAM Role"
  value       = module.iam.lambda_role_arn
}

output "glue_role_arn" {
  description = "ARN of the Glue IAM Role"
  value       = module.iam.glue_role_arn
}