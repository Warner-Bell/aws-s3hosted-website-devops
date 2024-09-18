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

# Echo the template path and change set name
echo "Template path: $S3_BUCKETS_TEMPLATE"
echo "Change set name: $CHANGE_SET_NAME"

# Validate the template
if ! cfn-lint -t "$S3_BUCKETS_TEMPLATE"; then
    echo "Template validation failed some checks" >&2
    read -p "Do you want to continue despite linting failures? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo "Deployment cancelled by user"
        exit 0
    fi
else
    echo "Template validation passed all checks"
fi

# Prompt user to continue with deployment
read -p "Do you want to proceed with deployment? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Deployment cancelled by user"
    exit 0
fi

# Deploy the stack and capture the change set ARN
CHANGE_SET_ARN=$(aws cloudformation deploy \
    --region "$AWS_REGION" \
    --stack-name "$S3_BUCKETS_STACK" \
    --s3-bucket "$CFN_BUCKET" \
    --template-file "$S3_BUCKETS_TEMPLATE" \
    --no-execute-changeset \
    --tags "$TAG_KEY=$TAG_VALUE" \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
        SiteBucketName="$SITE_BUCKET_NAME" \
        WWWBucketName="$WWW_BUCKET_NAME" \
        LogsBucketName="$LOGS_BUCKET_NAME" \
        DomainName="$DOMAIN_NAME" \
        TagKey="$TAG_KEY" \
        TagValue="$TAG_VALUE" \
    | grep -o 'arn:aws:cloudformation:.*')

if [ -z "$CHANGE_SET_ARN" ]; then
    echo "Failed to capture change set ARN" >&2
    exit 1
fi

echo "Change set ARN: $CHANGE_SET_ARN"

# Describe the change set and automatically exit the pager
PAGER="cat" aws cloudformation describe-change-set --change-set-name "$CHANGE_SET_ARN"


# Prompt to execute the change set
read -p "Do you want to execute the change set? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    aws cloudformation execute-change-set --change-set-name "$CHANGE_SET_ARN"
    echo "Change set execution initiated"

    # Wait for stack to complete or timeout
    SECONDS=0
    while true; do
        STATUS=$(aws cloudformation describe-stacks --stack-name "$S3_BUCKETS_STACK" --query 'Stacks[0].StackStatus' --output text)
        if [[ "$STATUS" == *COMPLETE ]]; then
            echo "Stack update completed successfully"
            break
        elif [[ "$STATUS" == *FAILED ]]; then
            echo "Stack update failed"
            exit 1
        elif [ $SECONDS -ge $STACK_UPDATE_TIMEOUT ]; then
            echo "Timeout reached. Stack update taking longer than expected"
            exit 1
        fi
        echo "Waiting for stack update to complete... (Status: $STATUS)"
        sleep 30
    done
else
    echo "Change set not executed"
fi
