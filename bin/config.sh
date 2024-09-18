# Configuration file for S3-hosted website CloudFormation deployment
# Version: 1.0
# Last Updated: 2024-09-05

# IMPORTANT!!!: Replace CFN_Bucket, S3 BucketNames, DomainName, HostedZoneId, & Tagging placeholders with your actual values before use.

# AWS Region
AWS_REGION="us-east-1"  # Specify your desired AWS region

# Stack Names
S3_BUCKETS_STACK="S3WebSite-Buckets"       # Name for the S3 buckets CloudFormation stack
CLOUDFRONT_STACK="S3WebSite-CDN-DNS-SSL"       # Name for the CloudFront distribution stack
DYNAMODB_STACK="S3WebSite-DB-Lambda"         # Name for the DynamoDB table stack
S3_POLICIES_STACK="S3WebSite-BucketPolicies"      # Name for the S3 bucket policies stack

# S3 BucketNames
CFN_BUCKET="cfmtn-stacks-2025"  # Existing S3 bucket to store CloudFormation templates
SITE_BUCKET_NAME="thecontentcaddie.com"       # Name for the main website content bucket
WWW_BUCKET_NAME="www.thecontentcaddie.com"        # Name for the www subdomain redirect bucket
LOGS_BUCKET_NAME="logs.thecontentcaddie.com"       # Name for the bucket to store access logs

# S3bucket Website Directory Name
WEBSITE_DIR="website-prod"

# Domain Configuration
DOMAIN_NAME="thecontentcaddie.com"            # Your custom domain name (e.g., example.com)
HOSTED_ZONE_ID="Z02755292T2THQUPWZK7C"         # Route 53 Hosted Zone ID for your domain

# Template Paths
S3_BUCKETS_TEMPLATE="${PWD}/cfn/1-s3Buckets.yaml"      # Path to S3 buckets template
CLOUDFRONT_TEMPLATE="${PWD}/cfn/2-cloudfrnt.yaml"      # Path to CloudFront template
DYNAMODB_TEMPLATE="${PWD}/cfn/3-dynamodb.yaml"         # Path to DynamoDB template
S3_POLICIES_TEMPLATE="${PWD}/cfn/4-s3Bucketpolicies.yaml"  # Path to S3 policies template

# Tagging
TAG_KEY="Workload"           # Key for resource tagging
TAG_VALUE="Test-S3Website" # Value for resource tagging

# Generate a unique change set name
CHANGE_SET_NAME="S3WebSiteDeploy-$(date +%Y%m%d%H%M%S)"

# Timeout for stack update (in seconds)
STACK_UPDATE_TIMEOUT=900  # 15 minutes


# Note: Ensure that SITE_BUCKET_NAME, WWW_BUCKET_NAME, and LOGS_BUCKET_NAME
# match the corresponding values in your CloudFormation templates
