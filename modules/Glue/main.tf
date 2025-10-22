# ───────────────────────────────
# Create Glue script & temp buckets
# ───────────────────────────────
resource "aws_s3_bucket" "glue_scripts_bucket" {
  bucket        = "${var.project_prefix}-glue-scripts"
  force_destroy = true
}

resource "aws_s3_bucket" "glue_temp_bucket" {
  bucket        = "${var.project_prefix}-glue-temp"
  force_destroy = true
}

# Upload transform.py to script bucket
resource "aws_s3_object" "glue_script" {
  bucket = aws_s3_bucket.glue_scripts_bucket.bucket
  key    = "scripts/transform.py"
  source = "${path.module}/scripts/transform.py"
  etag   = filemd5("${path.module}/scripts/transform.py")
}

# ───────────────────────────────
# Create Glue Database & Crawler
# ───────────────────────────────
resource "aws_glue_catalog_database" "data_catalog" {
  name = "${var.project_prefix}_catalog"
}

resource "aws_glue_crawler" "processed_data_crawler" {
  name         = "${var.project_prefix}-crawler"
  role         = var.glue_role_arn
  database_name = aws_glue_catalog_database.data_catalog.name
  description  = "Crawler to read processed CSV data and update Glue Catalog"

  s3_target {
    path = "s3://${var.processed_bucket}/"
  }

  # Run manually (no schedule)
  schedule = null
}

# ───────────────────────────────
# Glue Job definition
# ───────────────────────────────
resource "aws_glue_job" "data_transformation_job" {
  name     = "${var.project_prefix}_data_transformation"
  depends_on = [aws_s3_object.glue_script]
  role_arn = var.glue_role_arn

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://${aws_s3_bucket.glue_scripts_bucket.bucket}/${aws_s3_object.glue_script.key}"
  }

  default_arguments = {
    "--TempDir"        = "s3://${aws_s3_bucket.glue_temp_bucket.bucket}/"
    "--job-language"   = "python"
    "--processed_bucket" = var.processed_bucket
    "--final_bucket"     = var.final_bucket
  }

  glue_version = "4.0"
  max_retries  = 0
  timeout      = 10
  number_of_workers = 2
  worker_type       = "G.1X"
}
#