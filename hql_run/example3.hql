DROP TABLE IF EXISTS $(hiveconf:environemnt)_structured_product.table3;

CREATE EXTERNAL TABLE $(hiveconf:environemnt)_structured_product.table3
(
   IPH_CODE  STRING,
   DELETED  STRING,
   DELETION_DATE  STRING,
   DATE  STRING,
   source  STRING,
   loadin  STRING
)
COMMENT 't_gbo_group_signature'
ROW FORMAT
DELIMITED FIELDS TERMINATED BY '/;'
LINES TERMINATED BY '/n'
STORED AS PARQUET
LOCATION '/$(hiveconf:environemnt)/SHARED/STRUCTURED/GBO/PRODUCT/t_gbo_group_signature'
TBLPROPERTIES ("parquet.compression"="SNAPPY");

MSCK REPAIR TABLE $(hiveconf:environemnt)t_gbo_group_signature;

