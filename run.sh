#!/bin/bash

mkdir -p ./creds    
gcloud secrets versions access latest --secret=SERVICEACCOUNT_bigquery --format='get(payload.data)' | tr '_-' '/+' | base64 -d > ./creds/serviceaccount.json
gcloud auth activate-service-account --key-file ./creds/serviceaccount.json
chmod +x ./cmd.sh  && ./cmd.sh
bq --project_id=$PROJECT_ID --location=${_location} query --nouse_legacy_sql < union.sql


