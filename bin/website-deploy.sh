#!/usr/bin/env bash
set -eo pipefail

# Check if config.sh exists
if [ ! -f "./bin/config.sh" ]; then
    echo "Error: config.sh not found" >&2
    exit 1
fi

# Source the configuration file
source ./bin/config.sh

# Check AWS CLI version
aws_version=$(aws --version 2>&1 | cut -d/ -f2 | cut -d' ' -f1)
required_version="2.0.0"
if [ "$(printf '%s\n' "$required_version" "$aws_version" | sort -V | head -n1)" != "$required_version" ]; then
    echo "Error: AWS CLI version $required_version or higher is required" >&2
    exit 1
fi

# Function to deploy CloudFormation stack and wait for completion
deploy_stack_and_wait() {
    local stack_name=$1
    local template_file=$2
    shift 2

    # Check if the stack already exists
    if aws cloudformation describe-stacks --stack-name "$stack_name" &>/dev/null; then
        echo "Stack $stack_name already exists. Skipping deployment."
        return 0
    fi

    echo "Deploying stack: $stack_name"
    if aws cloudformation deploy \
        --region "$AWS_REGION" \
        --stack-name "$stack_name" \
        --s3-bucket "$CFN_BUCKET" \
        --template-file "$template_file" \
        --tags "$TAG_KEY=$TAG_VALUE" \
        --capabilities CAPABILITY_NAMED_IAM \
        --parameter-overrides "$@"; then
        echo "Stack $stack_name deployment initiated. Waiting for completion..."
        
        local max_attempts=60  # 30 minutes (30 * 60 seconds)
        local attempt=0
        while [ $attempt -lt $max_attempts ]; do
            status=$(aws cloudformation describe-stacks --stack-name "$stack_name" --query "Stacks[0].StackStatus" --output text)
            if [[ "$status" == *COMPLETE ]]; then
                echo "Stack $stack_name deployed successfully."
                return 0
            elif [[ "$status" == *FAILED ]]; then
                echo "Failed to deploy stack $stack_name. Status: $status" >&2
                return 1
            fi
            echo "Current status: $status. Waiting..."
            sleep 30
            ((attempt++))
        done
        echo "Timed out waiting for stack $stack_name to complete." >&2
        return 1
    else
        echo "Failed to initiate deployment for stack $stack_name" >&2
        return 1
    fi
}


# Deploy the buckets stack 
if ! deploy_stack_and_wait "$S3_BUCKETS_STACK" "$S3_BUCKETS_TEMPLATE" \
    SiteBucketName="$SITE_BUCKET_NAME" \
    WWWBucketName="$WWW_BUCKET_NAME" \
    LogsBucketName="$LOGS_BUCKET_NAME" \
    DomainName="$DOMAIN_NAME" \
    TagKey="$TAG_KEY" \
    TagValue="$TAG_VALUE"; then
    echo "Deployment of S3 buckets stack failed. Exiting." >&2
    exit 1
fi


# Deploy the cloudfront stack
if ! deploy_stack_and_wait "$CLOUDFRONT_STACK" "$CLOUDFRONT_TEMPLATE" \
    DomainName="$DOMAIN_NAME" \
    HostedZoneId="$HOSTED_ZONE_ID" \
    S3BucketsStackName="$S3_BUCKETS_STACK_NAME" \
    LogsBucketName="$LOGS_BUCKET_NAME" \
    SiteBucketName="$SITE_BUCKET_NAME" \
    TagKey="$TAG_KEY" \
    TagValue="$TAG_VALUE"; then
    echo "Deployment of CloudFront stack failed. Exiting." >&2
    exit 1
fi


# Deploy the db stack
if ! deploy_stack_and_wait "$DYNAMODB_STACK" "$DYNAMODB_TEMPLATE" \
    SiteBucketName="$SITE_BUCKET_NAME" \
    WWWBucketName="$WWW_BUCKET_NAME" \
    LogsBucketName="$LOGS_BUCKET_NAME" \
    DomainName="$DOMAIN_NAME" \
    TagKey="$TAG_KEY" \
    TagValue="$TAG_VALUE"; then
    echo "Deployment of DynamoDB stack failed. Exiting." >&2
    exit 1
fi


# Deploy the bucket policy stack
if ! deploy_stack_and_wait "$S3_POLICIES_STACK" "$S3_POLICIES_TEMPLATE" \
    SiteBucketName="$SITE_BUCKET_NAME" \
    WWWBucketName="$WWW_BUCKET_NAME" \
    LogsBucketName="$LOGS_BUCKET_NAME" \
    CloudFrontStackName="$CLOUDFRONT_STACK_NAME" \
    TagKey="$TAG_KEY" \
    TagValue="$TAG_VALUE"; then
    echo "Deployment of S3 policies stack failed. Exiting." >&2
    exit 1
fi


# Sync S3 files
if [ -f "./bin/s3sync-files.sh" ]; then
    if ./bin/s3sync-files.sh; then
        echo "S3 sync completed successfully."
    else
        echo "Failed to sync S3 files" >&2
        exit 1
    fi
else
    echo "Error: s3sync-files.sh not found" >&2
    exit 1
fi

