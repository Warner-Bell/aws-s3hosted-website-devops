# Config Setup Guide

This document explains how to set up and configure the `config.sh` file for deploying an S3-hosted website

## Prerequisites

Before proceeding, ensure you have the following:

- A custom domain name registered and managed through AWS Route 53. and the (Hosted Zone ID) Walkthrough video [HERE](https://youtu.be/QnI_Xevpqts)
- Existing S3 bucket to store CloudFormation templates. [Amazon S3](https://us-east-1.console.aws.amazon.com/s3/buckets)

## How to Use This Guide

Follow these steps to correctly update the `config.sh` file. The placeholders in the file need to be replaced with your actual values.

---

## Key Variables to Update

The following variables **must** be updated in your `config.sh` file before use. Ensure that all values correspond to your specific AWS setup.

### 1. **AWS_REGION**
   - **Description**: The AWS region where the resources will be deployed.
   - **Default Value**: `us-east-1`
   - **Example**:
     ```bash
     AWS_REGION="us-east-1"
     ```
   - **Action**: Update this value to your desired region if different.

### 2. **CFN_BUCKET**
   - **Description**: The name of an existing S3 bucket where CloudFormation templates are or can be stored.
   - **Example**:
     ```bash
     CFN_BUCKET="cfmtn-stacks-2025" #don't use this example it will fail
     ```
   - **Action**: Replace `cfmtn-stacks-2025` with the name of your CloudFormation template bucket.

### 3. **SITE_BUCKET_NAME**
   - **Description**: The S3 bucket for hosting your website content.
   - **Example**:
     ```bash
     SITE_BUCKET_NAME="yourdomainname.com"
     ```
   - **Action**: Replace `yourdomainname.com` with your custom domain name (e.g., `example.com`).

### 4. **WWW_BUCKET_NAME**
   - **Description**: The S3 bucket for redirecting `www` subdomain traffic to your primary domain.
   - **Example**:
     ```bash
     WWW_BUCKET_NAME="www.yourdomainname.com"
     ```
   - **Action**: Replace `yourdomainname` with your custom domain name (e.g., `example.com`).

### 5. **LOGS_BUCKET_NAME**
   - **Description**: The S3 bucket used to store access logs.
   - **Example**:
     ```bash
     LOGS_BUCKET_NAME="logs.yourdomainname.com"
     ```
   - **Action**: Replace `yourdomainname` with your custom domain name.

### 6. **DOMAIN_NAME**
   - **Description**: The custom domain name to use with your website.
   - **Example**:
     ```bash
     DOMAIN_NAME="yourdomainname.com"
     ```
   - **Action**: Replace `yourdomainname.com` with your actual domain name (e.g., `example.com`).

### 7. **HOSTED_ZONE_ID**
   - **Description**: The Route 53 Hosted Zone ID for your domain.
   - **Example**:
     ```bash
     HOSTED_ZONE_ID="Z02755292T2THQUFHEKHTC"
     ```
   - **Action**: Replace `Z02755292T2THQUPWZK7C` with your own Route 53 Hosted Zone ID. You can find this ID in the Route 53 console under the Hosted Zones section. [RT53 Hosted Zones](https://us-east-1.console.aws.amazon.com/route53/v2/hostedzones)

---

## Other Configurations

### 1. **Stack Names**
   These names are used to reference CloudFormation stacks for different resources.
   - **Action**: These values can remain as they are or be customized if necessary.
   - **Example**:
     ```bash
     S3_BUCKETS_STACK="S3WebSite-Buckets"
     CLOUDFRONT_STACK="S3WebSite-CDN-DNS-SSL"
     DYNAMODB_STACK="S3WebSite-DB-Lambda"
     S3_POLICIES_STACK="S3WebSite-BucketPolicies"
     ```

### 2. **Template Paths**
   Ensure that the paths to your CloudFormation templates are correct. These paths are relative to where your templates are located in the repository.
   - **Action**: Verify the paths to each template and update if necessary.
   - **Example**:
     ```bash
     S3_BUCKETS_TEMPLATE="${PWD}/cfn/1-s3Buckets.yaml"
     CLOUDFRONT_TEMPLATE="${PWD}/cfn/2-cloudfrnt.yaml"
     DYNAMODB_TEMPLATE="${PWD}/cfn/3-dynamodb.yaml"
     S3_POLICIES_TEMPLATE="${PWD}/cfn/4-s3Bucketpolicies.yaml"
     ```

### 3. **Tagging**
   Tags are applied to resources for identification purposes.
   - **Action**: Customize these tags if needed, but they are optional.
   - **Example**:
     ```bash
     TAG_KEY="Workload"
     TAG_VALUE="YourS3Website"
     ```

### 4. **Change Set Name**
   The change set name is generated automatically based on the current timestamp. This ensures uniqueness during deployments. You can leave this value unchanged.
   - **Example**:
     ```bash
     CHANGE_SET_NAME="S3WebSiteDeploy-$(date +%Y%m%d%H%M%S)"
     ```
