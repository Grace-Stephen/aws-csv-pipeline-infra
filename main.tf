module "S3" {
  source          = "./modules/S3"
  project_prefix  = var.project_prefix
}

# --- IAM Module ---
module "iam" {
  source = "./modules/iam"
}

module "lambda" {
  source           = "./modules/lambda"
  project_prefix   = var.project_prefix
  lambda_role_arn  = module.iam.lambda_role_arn
  raw_bucket       = module.S3.raw_bucket_name
  processed_bucket = module.S3.processed_bucket_name
}

module "S3_trigger" {
  source = "./modules/S3_trigger"

  raw_bucket           = module.S3.raw_bucket_name
  raw_bucket_arn       = module.S3.raw_bucket_arn
  lambda_function_arn  = module.lambda.lambda_function_arn
}

module "glue" {
  source          = "./modules/Glue"
  project_prefix  = var.project_prefix
  glue_role_arn   = module.iam.glue_role_arn  # IAM role for Glue
  processed_bucket = module.S3.processed_bucket_name
  final_bucket     = module.S3.final_bucket_name
}
