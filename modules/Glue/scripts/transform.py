import sys
from awsglue.utils import getResolvedOptions
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.context import SparkContext

# ✅ Fetch arguments passed from Terraform (defined in default_arguments)
args = getResolvedOptions(sys.argv, [
    'JOB_NAME',
    'processed_bucket',
    'final_bucket'
])

# Initialize Glue and Spark contexts
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

print(f"Reading data from s3://{args['processed_bucket']}/")

# ✅ Read CSV data from the processed S3 bucket
datasource = glueContext.create_dynamic_frame.from_options(
    connection_type="s3",
    connection_options={"paths": [f"s3://{args['processed_bucket']}/processed/"]},
    format="csv",
    format_options={"withHeader": True}
)

# ✅ Drop unnecessary columns (example: “icon”)
transformed = datasource.drop_fields(["icon"])

print(f"Writing transformed data to s3://{args['final_bucket']}/transformed/")

# ✅ Write transformed CSV to the final S3 bucket
glueContext.write_dynamic_frame.from_options(
    frame=transformed,
    connection_type="s3",
    connection_options={"path": f"s3://{args['final_bucket']}/transformed/"},
    format="csv"
)

job.commit()

print("✅ Transformation complete and data written successfully.")
