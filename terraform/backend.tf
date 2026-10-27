# Remote state: keeps Terraform state in S3 so every pipeline run
# sees the resources created by earlier runs, instead of starting
# from an empty state and trying to create everything again.
# The bucket and lock table must exist before `terraform init`
# (see "Deploy to AWS" in the README).
terraform {
  backend "s3" {
    bucket         = "mopaul873-devops-dashboard-tfstate"
    key            = "devops-health-dashboard/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "mopaul873-devops-dashboard-tflocks"
    encrypt        = true
  }
}
