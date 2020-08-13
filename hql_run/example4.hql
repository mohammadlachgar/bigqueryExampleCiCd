DROP TABLE IF EXISTS $(hiveconf:environemnt)_structured_product.table4;

CREATE EXTERNAL TABLE $(hiveconf:environemnt)_structured_product.table4
(
   CODE STRING,
   DESCRIPTION  STRING,
   EXTRA_ORDER_LABEL  STRING,
   SORT_ORDER  STRING,
   IPH_CODE  STRING,
   DELETED  STRING  
)
COMMENT 't_gbo_group_signature'
ROW FORMAT
DELIMITED FIELDS TERMINATED BY '/;'
LINES TERMINATED BY '/n'
STORED AS PARQUET
LOCATION '/$(hiveconf:environemnt)/SHARED/STRUCTURED/GBO/PRODUCT/t_gbo_group_signature'
TBLPROPERTIES ("parquet.compression"="SNAPPY");

MSCK REPAIR TABLE $(hiveconf:environemnt)t_gbo_group_signature;

