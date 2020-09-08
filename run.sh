#!/bin/bash


. ./variables.sh

mkdir -p ./creds 

#  Add secret "SERVICEACCOUNT_bigquery" to /security/secret-manager
#  Enable "Secret Manager" in cloud-build/settings
gcloud secrets versions access latest --secret=$name_secret --format='get(payload.data)' | tr '_-' '/+' | base64 -d > ./creds/serviceaccount.json

gcloud auth activate-service-account --key-file ./creds/serviceaccount.json

chmod +x ./cmd.sh
. ./cmd.sh

gcloud alpha remote-build-execution worker-pools create default_instance \
    --project=$projectId \
    --instance=default_instance \
    --worker-count=2 \
    --machine-type=e2-micro \
    --disk-size=200


ls

bq query --dry_run --nouse_legacy_sql < union.sql

#bq --project_id=$projectId --location=$location_bigquery query --nouse_legacy_sql < union.sql


