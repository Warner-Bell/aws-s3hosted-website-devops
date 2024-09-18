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

echo "Using domain name: $DOMAIN_NAME"

# Get the distribution ID based on the domain name
DISTRIBUTION_ID=$(aws cloudfront list-distributions --query "DistributionList.Items[?contains(Aliases.Items, '$DOMAIN_NAME')].Id" --output text)

# Check if we got a valid distribution ID
if [ -z "$DISTRIBUTION_ID" ]; then
    echo "Error: Could not retrieve CloudFront distribution ID for domain $DOMAIN_NAME"
    exit 1
fi

# Print the distribution ID (optional, for verification)
echo "CloudFront Distribution ID: $DISTRIBUTION_ID"

# Create the invalidation
aws cloudfront create-invalidation --distribution-id "$DISTRIBUTION_ID" --paths "/*"

echo "Invalidation created successfully for distribution associated with $DOMAIN_NAME"
