#!/bin/bash


. ./variables.sh

mkdir -p ./creds 

#  Add secret "SERVICEACCOUNT_bigquery" to /security/secret-manager
#  Enable "Secret Manager" in cloud-build/settings
gcloud secrets versions access latest --secret=$name_secret --format='get(payload.data)' | tr '_-' '/+' | base64 -d > ./creds/serviceaccount.json

gcloud auth activate-service-account --key-file ./creds/serviceaccount.json

chmod +x ./cmd.sh
. ./cmd.sh

bazel version 

echo" clone zetasql.git"
git clone https://github.com/google/zetasql.git


echo " cd zetasql"
cd zetasql

echo " delete bazelversion"
rm .bazelversion

echo " bazel run"
bazel --verbose_failures run //zetasql/experimental:execute_query -- "select 1 + 1;"

#bq query --dry_run --nouse_legacy_sql < union.sql

#bq --project_id=$projectId --location=$location_bigquery query --nouse_legacy_sql < union.sql


