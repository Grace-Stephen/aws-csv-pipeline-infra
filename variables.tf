variable "aws_region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "us-east-1"
}

variable "project_prefix" {
  description = "Prefix for resource naming"
  type        = string
  default     = "ogoma"
}
