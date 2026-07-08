# Backend configuration for storing Terraform state in S3
#
# INSTRUCTIONS:
# 1. First run: `terraform init` (without backend - uses local state)
# 2. Apply the initial configuration: `terraform apply`
# 3. This will create the S3 bucket and CloudFront distribution
# 4. Once resources are created, uncomment the backend block below
# 5. Run: `terraform init -migrate-state` to migrate local state to S3 backend
#
# Replace the following values:
# - bucket: Your S3 bucket name for storing terraform state
# - key: Path to the state file within the bucket (e.g., "portfolio-site/terraform.tfstate")
# - region: AWS region where the state bucket is located
# - dynamodb_table: DynamoDB table name for state locking
#
# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"
#     key            = "portfolio-site/terraform.tfstate"
#     region         = "ap-south-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }
