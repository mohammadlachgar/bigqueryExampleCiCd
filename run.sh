#!/bin/bash
projectId="burnished-case-280710"
location_bigquery="US"
name_secret="SERVICEACCOUNT_bigquery"
dataset_bigquery="dataset_ex2"

mkdir -p ./creds 

# Add secret "SERVICEACCOUNT_bigquery" to /security/secret-manager
# Enable "Secret Manager" in cloud-build/settings
gcloud secrets versions access latest --secret=$name_secret --format='get(payload.data)' | tr '_-' '/+' | base64 -d > ./creds/serviceaccount.json

gcloud auth activate-service-account --key-file ./creds/serviceaccount.json

# chmod +x ./cmd.sh  && ./cmd.sh
chmod +x ./cmd.sh
. ./cmd.sh

bq --project_id=$projectId --location=$location_bigquery query --nouse_legacy_sql < union.sql


