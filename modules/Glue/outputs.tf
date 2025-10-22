output "glue_database_name" {
  description = "The Glue Data Catalog database name"
  value       = aws_glue_catalog_database.data_catalog.name
}

output "glue_crawler_name" {
  description = "The Glue crawler name"
  value       = aws_glue_crawler.processed_data_crawler.name
}

output "glue_job_name" {
  description = "The Glue ETL job name"
  value       = aws_glue_job.data_transformation_job.name
}

output "glue_script_bucket" {
  description = "The S3 bucket where Glue scripts are stored"
  value       = aws_s3_bucket.glue_scripts_bucket.bucket
}

output "glue_temp_bucket" {
  description = "The S3 bucket used for Glue temporary files"
  value       = aws_s3_bucket.glue_temp_bucket.bucket
}
