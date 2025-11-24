AWS Serverless CSV Pipeline — Automated Ingestion & Semi-Automated Transformation (Terraform + GitHub Actions)

Overview

This project implements a serverless data ingestion pipeline on AWS using Terraform for infrastructure provisioning and GitHub Actions for deployment automation.
The pipeline ingests raw CSV files uploaded to S3, preprocesses them using AWS Lambda, and prepares them for downstream transformation using AWS Glue.

While the pipeline automated infrastructure provisioning and raw-data ingestion, it was not fully automated end-to-end.
The Glue crawler and Glue job required manual triggering, which is one of the limitations addressed in the later Shopify Warehouse Data Pipeline project.

This project serves as the foundational version, demonstrating how to combine Terraform, Lambda, and S3 event notifications to automate ingestion with minimal console interaction.


Key Objectives

- Provision a serverless data pipeline using AWS-managed services

- Automate infrastructure deployment using Terraform

- Trigger preprocessing automatically upon CSV upload

- Prepare data for ETL using AWS Glue

- Demonstrate CI/CD integration with GitHub Actions

Architecture

Pipeline Flow

1. Amazon S3 — Raw Bucket
Users upload raw CSV files manually or programmatically.

2. S3 Event Notifications
Automatically trigger a Lambda function whenever a file is uploaded.

3. AWS Lambda (Preprocessing)

- Validates / cleans raw CSVs

- Saves preprocessed output to a processed S3 bucket

4. Amazon S3 — Processed Bucket
Stores Lambda output for consumption by AWS Glue.

5. AWS Glue (Crawler + Job)

- The Glue crawler catalogs the processed data

- The Glue ETL script transforms and outputs final results
These steps were manually triggered in this project.

6. Terraform

Automates all infrastructure provisioning

7. GitHub Actions

- Automates Terraform deployment

- Automates upload of Glue scripts to the scripts bucket

Key Features
AUTOMATED

- Terraform IaC for S3, IAM, Lambda, Glue

- Lambda triggered automatically by S3 events

- GitHub Actions workflow to apply Terraform and sync Glue scripts

SEMI-AUTOMATED

- Running Glue crawler

- Running Glue ETL job

MANUAL COMPONENTS

- Executing Glue job

- Triggering Glue crawler

CI/CD Workflow Summary
1. Terraform Automation (GitHub Actions)

On push to main:

- terraform init

- terraform plan

- terraform apply

State stored in S3 backend.

2. Glue Script Automatic Upload

A separate workflow syncs the ETL script to the scripts bucket:
"aws s3 cp ./modules/Glue/scripts/transform.py s3://ogoma-glue-scripts/scripts/transform.py
"

3. Data Flow After Provisioning

- Upload a CSV to raw-data-bucket/

- S3 triggers Lambda

- Lambda preprocesses data and stores output in processed-data-bucket/

- (Manual) Run Glue crawler

- (Manual) Start Glue ETL job

- ETL writes output to final-data-bucket/


Learning Highlights

Through this project, I gained experience in:

- Structuring serverless pipelines using modular Terraform

- Implementing S3 → Lambda event-driven ingestion

- Understanding Glue crawlers, jobs, and scripts

- Managing IAM least-privilege roles for serverless apps

- Using GitHub Actions for IaC automation

- Debugging issues around S3 backend, resource references and dependencies


Conclusion

This AWS CSV Pipeline project demonstrates the core principles of serverless ingestion, IaC automation, and event-driven processing.

While not fully automated, it provides a clear, modular, and extensible foundation on which more advanced pipelines (like the Shopify Warehouse Project) are built.

It is a solid starting point for understanding real-world cloud ETL workflows and evolving them toward production-grade orchestration.
