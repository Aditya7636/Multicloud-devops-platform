#!/usr/bin/env bash
set -euo pipefail

REGION="eu-west-2"
PROJECT="mcdp"
ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"

BUCKET="${PROJECT}-tfstate-${ACCOUNT_ID}-${REGION}"
TABLE="${PROJECT}-tfstate-lock"

echo "Creating S3 bucket: ${BUCKET} in ${REGION}"
aws s3api create-bucket \
  --bucket "${BUCKET}" \
  --region "${REGION}" \
  --create-bucket-configuration LocationConstraint="${REGION}" 2>/dev/null || true

echo "Enabling bucket versioning"
aws s3api put-bucket-versioning \
  --bucket "${BUCKET}" \
  --versioning-configuration Status=Enabled

echo "Enabling default encryption"
aws s3api put-bucket-encryption \
  --bucket "${BUCKET}" \
  --server-side-encryption-configuration '{
    "Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]
  }'

echo "Blocking public access"
aws s3api put-public-access-block \
  --bucket "${BUCKET}" \
  --public-access-block-configuration \
    BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

echo "Creating DynamoDB lock table: ${TABLE}"
aws dynamodb create-table \
  --table-name "${TABLE}" \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region "${REGION}" 2>/dev/null || true

echo ""
echo "Terraform backend ready:"
echo "bucket         = ${BUCKET}"
echo "dynamodb_table = ${TABLE}"
echo "region         = ${REGION}"
