DROP TABLE IF EXISTS $(hiveconf:environemnt)_structured_product.t_gbo_ref_group_signature;
DROP TABLE IF EXISTS $(hiveconf:environemnt)_structured_product.t_gbo_group_signature;

CREATE EXTERNAL TABLE $(hiveconf:environemnt)_structured_product.t_gbo_group_signature
(
   GROUP_SIGNATURE_CODE STRING,
   DESCRIPTION  STRING,
   EXTRA_ORDER_LABEL  STRING,
   SORT_ORDER  STRING,
   IPH_CODE  STRING,
   DELETED  STRING,
   DELETION_DATE  STRING,
   RUNNING_DATE  STRING,
   system_source  STRING,
   loadin_date  STRING
)
COMMENT 't_gbo_group_signature'
ROW FORMAT
DELIMITED FIELDS TERMINATED BY '/;'
LINES TERMINATED BY '/n'
STORED AS PARQUET
LOCATION '/$(hiveconf:environemnt)/SHARED/STRUCTURED/GBO/PRODUCT/t_gbo_group_signature'
TBLPROPERTIES ("parquet.compression"="SNAPPY");

MSCK REPAIR TABLE $(hiveconf:environemnt)t_gbo_group_signature;
