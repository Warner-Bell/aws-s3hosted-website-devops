#!/usr/bin/env bash

# Stop execution if any command fails
set -e

# Set the path to the config file using PWD
CONFIG_FILE="${PWD}/bin/config.sh"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Config file not found at $CONFIG_FILE"
    exit 1
fi

source "$CONFIG_FILE"

# Ensure DOMAIN_NAME is set
if [ -z "$DOMAIN_NAME" ]; then
    echo "Error: DOMAIN_NAME is not set in the config file"
    exit 1
fi

# Ensure S3_BUCKET is set
if [ -z "$SITE_BUCKET_NAME" ]; then
    echo "Error: S3_BUCKET is not set in the config file"
    exit 1
fi

# Ensure WEBSITE_DIR is set
if [ -z "$WEBSITE_DIR" ]; then
    echo "Error: WEBSITE_DIR is not set in the config file"
    exit 1
fi

echo "Using domain name: $DOMAIN_NAME"

FULL_WEBSITE_PATH="${PWD}/${WEBSITE_DIR}"

if [ ! -d "$FULL_WEBSITE_PATH" ]; then
    echo "Error: Website directory not found at $FULL_WEBSITE_PATH"
    exit 1
fi

# Perform the S3 sync
echo "Syncing files to S3 bucket: $SITE_BUCKET_NAME"
aws s3 sync "$FULL_WEBSITE_PATH" "s3://$SITE_BUCKET_NAME" --delete

echo "S3 sync completed successfully"

# Get the distribution ID based on the domain name
echo "Attempting to retrieve CloudFront distribution ID for domain: $DOMAIN_NAME"
DISTRIBUTION_ID=$(aws cloudfront list-distributions --query "DistributionList.Items[?Aliases.Items && contains(Aliases.Items, 'thecontentcaddie.com')].Id" --output text)

# Check if we got a valid distribution ID
if [ -z "$DISTRIBUTION_ID" ] || [ "$DISTRIBUTION_ID" = "None" ]; then
    echo "Warning: Could not retrieve CloudFront distribution ID for domain $DOMAIN_NAME"
    echo "Listing all CloudFront distributions:"
    aws cloudfront list-distributions --query "DistributionList.Items[].{Id:Id, DomainName:DomainName, Aliases:Aliases.Items}" --output table
    echo "Skipping CloudFront invalidation."
else
    # Print the distribution ID (optional, for verification)
    echo "CloudFront Distribution ID: $DISTRIBUTION_ID"

    # Create the invalidation
echo "Creating CloudFront invalidation..."
INVALIDATION_OUTPUT=$(aws cloudfront create-invalidation --distribution-id "$DISTRIBUTION_ID" --paths "/*" --query 'Invalidation.[Id,Status]' --output text)

# Display the essential information
echo "Invalidation created:"
echo "$INVALIDATION_OUTPUT" | sed 's/\t/\nStatus: /'

# Exit the script
exit 0

    echo "Invalidation created successfully for distribution associated with $DOMAIN_NAME"
fi

