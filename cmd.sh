#!/bin/bash

#convert hql to sql standard
find hql_run/. -type f -name "*.hql" -print0 | xargs -0 \
sed -i -z -E \
'
s/(\$\(hiveconf:environemnt\)\w+)\.(\w+)/`'$PROJECT_ID'.dataset_ex2.\2`/g;
s/CREATE\s+EXTERNAL\s+TABLE/CREATE TABLE/g;
s/(\n|\r)\s*\)\s*(\n|\r).*(\n*\r*\n*.*)*/\n);/g
'

#merge all content to one file
find hql_run/. -type f -name "*.hql" | xargs cat > ./union.sql
