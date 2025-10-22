output "raw_bucket_name" {
  value = aws_s3_bucket.raw_data.bucket
}

output "processed_bucket_name" {
  value = aws_s3_bucket.processed_data.bucket
}

output "final_bucket_name" {
  value = aws_s3_bucket.final_data.bucket
}

output "raw_bucket_arn" {
  value = aws_s3_bucket.raw_data.arn
}

output "processed_bucket_arn" {
  value = aws_s3_bucket.processed_data.arn
}

output "final_bucket_arn" {
  value = aws_s3_bucket.final_data.arn
}
