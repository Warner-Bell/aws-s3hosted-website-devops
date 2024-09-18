#!/usr/bin/env bash
set -eo pipefail

# Source the configuration file
source ./bin/config.sh

# Set variables
HOSTED_ZONE_ID=${HOSTED_ZONE_ID}
RECORD_TYPES="CNAME A"

# Function to handle errors
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Function to delete a CloudFormation stack and wait for completion
delete_stack_and_wait() {
    local stack_name=$1
    echo "Deleting stack: $stack_name"
    if aws cloudformation delete-stack --stack-name "$stack_name"; then
        echo "Waiting for stack $stack_name to be deleted..."
        if aws cloudformation wait stack-delete-complete --stack-name "$stack_name"; then
            echo "Stack $stack_name deleted successfully."
        else
            error_exit "Failed to delete stack $stack_name"
        fi
    else
        error_exit "Failed to initiate deletion of stack $stack_name"
    fi
}

# List and format resource record sets
RECORD_SETS=$(aws route53 list-resource-record-sets \
    --hosted-zone-id "$HOSTED_ZONE_ID" \
    --query "ResourceRecordSets[?Type=='CNAME'||Type=='A']" \
    --output json)

# Check if there are any records to delete
if [ "$(echo "$RECORD_SETS" | jq 'length')" -gt 0 ]; then
    CHANGE_BATCH=$(echo "$RECORD_SETS" | jq '{Changes: [.[] | {Action: "DELETE", ResourceRecordSet: .}]}')
    
    # Delete resource record sets
    aws route53 change-resource-record-sets \
        --hosted-zone-id "$HOSTED_ZONE_ID" \
        --change-batch "$CHANGE_BATCH" \
        && echo "Resource Record Sets deleted successfully." \
        || error_exit "Failed to delete Resource Record Sets"
else
    echo "No matching resource record sets found to delete."
fi


## Function to safely empty an S3 bucket
# empty_s3_bucket() {
#     local bucket_name=$1
#     if aws s3 ls "s3://${bucket_name}" &>/dev/null; then
#         if [ -z "$(aws s3 ls "s3://${bucket_name}")" ]; then
#             echo "Bucket ${bucket_name} is already empty."
#         else
#             echo "Emptying bucket ${bucket_name}..."
#             aws s3 rm "s3://${bucket_name}" --recursive && echo "Bucket ${bucket_name} emptied successfully." || echo "Failed to empty ${bucket_name}, but continuing..."
#         fi
#     else
#         echo "Bucket ${bucket_name} does not exist. Skipping."
#     fi
# }

##Empty S3 buckets
# empty_s3_bucket "${SITE_BUCKET_NAME}"
# empty_s3_bucket "${WWW_BUCKET_NAME}"
# empty_s3_bucket "${LOGS_BUCKET_NAME}"

# echo "All operations completed successfully. (S3 Buckets remain but have been emptied if they existed!)"


# Delete CloudFormation stacks
delete_stack_and_wait "${S3_POLICIES_STACK}"
delete_stack_and_wait "${DYNAMODB_STACK}"
delete_stack_and_wait "${CLOUDFRONT_STACK}"
delete_stack_and_wait "${S3_BUCKETS_STACK}"

echo "All operations completed successfully. (S3 Buckets remain!)"



