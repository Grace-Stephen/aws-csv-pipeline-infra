resource "aws_s3_bucket" "raw_data" {
bucket = "${var.project_prefix}-raw-data"
}

resource "aws_s3_bucket" "processed_data" {
bucket = "${var.project_prefix}-processed-data"
}

resource "aws_s3_bucket" "final_data" {
bucket = "${var.project_prefix}-final-data"
}
#