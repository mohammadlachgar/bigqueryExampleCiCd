#!/bin/bash

#convert hql to sql standard
find hql_run/. -type f -name "*.hql" -print0 | xargs -0 \
sed -i -z -E \
'
s/(\$\(hiveconf:environemnt\)\w+)\.(\w+)/`'$projectId'.'$dataset_bigquery'.\2`/g;
s/CREATE\s+EXTERNAL\s+TABLE/CREATE TABLE/g;
s/(\n|\r)\s*\)\s*(\n|\r).*(\n*\r*\n*.*)*/\n);/g
'


#set variables to sql files
find sql_run/. -type f -name "*.sql" -print0 | xargs -0 \
sed -i -z -E \
'
s/\$project\$/'$projectId'/g;
s/\$dataset\$/'$dataset_bigquery'/g;
'


touch ./union.sql

#merge all content in 'hql_run' and 'sql_run' to one file "union.sql"
find hql_run/. -type f -name "*.hql" | xargs cat > ./union.sql
find sql_run/. -type f -name "*.sql" | xargs cat >> ./union.sql

cat ./union.sql