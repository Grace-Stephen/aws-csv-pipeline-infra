AWS Serverless Data Pipeline — Automated CSV Transformation with Terraform and GitHub Actions
Overview

This project implements a fully automated, serverless data pipeline on AWS using Terraform for infrastructure provisioning and GitHub Actions for CI/CD automation. The pipeline is designed to extract raw CSV data from S3, transform it using AWS Glue, and store the processed output back into another S3 bucket, making it immediately ready for analytics and visualization tools like Amazon QuickSight.

This setup removes manual intervention by automating the entire workflow from infrastructure deployment to data transformation.

Key Objectives

- Build a scalable, cost-efficient, and fully automated data pipeline using serverless AWS services.

- Demonstrate infrastructure automation with Terraform and deployment automation with GitHub Actions.

- Show how a pipeline can be triggered automatically on data uploads without human involvement.

Architecture Summary

Below is a breakdown of the architecture and how each AWS component interacts:

1. Amazon S3 (Raw Data Bucket) – Stores incoming raw CSV files.

2. S3 Event Trigger - Triggers AWS Lambda once data lands in the raw data bucket.

3. AWS Lambda – Automatically processes the raw data and uploads it to the processed data bucket.

4. AWS Glue – Transforms the preprocessed CSV data (e.g., cleaning, restructuring) and writes the output into the final data S3 bucket.

5. Amazon S3 (Processed Data Bucket) – Stores processed data, ready for transformation by AWS Glue.

6. Amazon S3 (Final Data Bucket) – Stores transformed data, ready for visualization or downstream analytics.

7. Terraform – Defines all infrastructure (S3 buckets, IAM roles, Lambda function, Glue job, event triggers) as code.

8. GitHub Actions – Automates Terraform commands and Glue job execution through CI/CD workflows.

Tools and Technologies
Category	: Tool
Infrastructure as Code:	Terraform
CI/CD Automation:	GitHub Actions
Data Processing:	AWS Glue
Event-Driven Computing:	AWS Lambda
Storage:	Amazon S3
Identity & Access Management:	AWS IAM
Programming Language:	Python (for Lambda and Glue script)

Repository Structure

- modules/ – Each module defines an independent resource group (IAM, Lambda, Glue, etc.).

- glue_script/ – Contains the Glue ETL script that performs the CSV transformation.

- lambda_code/ - Contains the lambda function code that preprocesses the raw data.

- .github/workflows/ – Defines automation pipelines for both Terraform and data processing.

CI/CD Workflow
1. Terraform Automation

Whenever a commit is pushed to the main branch:

GitHub Actions runs terraform init, plan, and apply.

The backend configuration stores Terraform state in an S3 bucket for remote management.

This ensures the entire AWS infrastructure is created or updated automatically.

2. Transformation Script Upload

A separate GitHub Action runs:

aws s3 cp ./modules/Glue/scripts/transform.py s3://ogoma-glue-scripts/scripts/transform.py

This command automatically uploads the transformation script to the Glue Script S3 bucket. This transformation script defines how AWS Glue transforms and stores the transformed data.

3. Glue Job Execution

A separate GitHub Action runs:

aws glue start-job-run --job-name <job_name>


This command automatically starts the Glue transformation job after infrastructure provisioning or whenever needed — eliminating manual triggers.


Automated Data Processing after Infrastructure Provisioning

- Upload a raw CSV file to the raw-data S3 bucket.

- S3 event triggers Lambda to process the raw data and store it in the processed data bucket for further transformation. 

- Lambda processes the data and stores it in the processed data bucket.

- The pipeline triggers the Glue job to run.

- The transformed output appears in the final-data S3 bucket.


Learning Highlights

This project deepened my understanding of:

- Designing modular Terraform infrastructure for serverless pipelines.

- Configuring Lambda-S3 event triggers for automation.

- Managing IAM permissions to ensure least privilege access.

- Deploying AWS Glue jobs with Terraform and running them via GitHub Actions.

- Handling real-world CI/CD issues like naming conventions, S3 backend configuration, and resource reference mismatches.


Conclusion

This project is more than a simple AWS setup, it’s a demonstration of how infrastructure as code, serverless design, and CI/CD pipelines can work together to create an automated, production-ready data workflow.

By fully automating deployment and transformation, this pipeline proves that even complex data processes can be simplified with the right tools and structure.