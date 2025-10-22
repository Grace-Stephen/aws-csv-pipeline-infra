variable "project_prefix" {
  description = "Prefix used for naming Glue resources"
  type        = string
}

variable "glue_role_arn" {
  description = "IAM Role ARN for Glue with S3 access"
  type        = string
}

variable "processed_bucket" {
  description = "Name of S3 bucket containing processed data"
  type        = string
}

variable "final_bucket" {
  description = "Name of S3 bucket for final transformed data"
  type        = string
}
