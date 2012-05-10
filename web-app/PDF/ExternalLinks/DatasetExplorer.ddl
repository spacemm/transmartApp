
  CREATE TABLE "I2B2DEMODATA"."CONCEPT_COUNTS" 
   (	"CONCEPT_PATH" VARCHAR2(500 BYTE), 
	"PARENT_CONCEPT_PATH" VARCHAR2(500 BYTE), 
	"PATIENT_COUNT" NUMBER(38,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 

  CREATE INDEX "I2B2DEMODATA"."CONCEPT_COUNTS_INDEX1" ON "I2B2DEMODATA"."CONCEPT_COUNTS" ("PARENT_CONCEPT_PATH") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS COMPRESS 1 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 

  CREATE TABLE "I2B2DEMODATA"."CONCEPT_DIMENSION" 
   (	"CONCEPT_CD" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"CONCEPT_PATH" VARCHAR2(700 BYTE) NOT NULL ENABLE, 
	"NAME_CHAR" VARCHAR2(2000 BYTE), 
	"CONCEPT_BLOB" CLOB, 
	"UPDATE_DATE" DATE, 
	"DOWNLOAD_DATE" DATE, 
	"IMPORT_DATE" DATE, 
	"SOURCESYSTEM_CD" VARCHAR2(50 BYTE), 
	"UPLOAD_ID" NUMBER, 
	"TABLE_NAME" VARCHAR2(255 BYTE)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" 
 LOB ("CONCEPT_BLOB") STORE AS BASICFILE (
  TABLESPACE "I2B2_DATA" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE NOLOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)) ;
 

  CREATE INDEX "I2B2DEMODATA"."IDX_CONCEPT_DIM_1" ON "I2B2DEMODATA"."CONCEPT_DIMENSION" ("CONCEPT_CD") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS COMPRESS 1 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 
  CREATE INDEX "I2B2DEMODATA"."IDX_CONCEPT_DIM_2" ON "I2B2DEMODATA"."CONCEPT_DIMENSION" ("CONCEPT_PATH") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS COMPRESS 1 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 
  CREATE UNIQUE INDEX "I2B2DEMODATA"."SYS_IL0000073072C00004$$" ON "I2B2DEMODATA"."CONCEPT_DIMENSION" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
 

  CREATE TABLE "I2B2DEMODATA"."OBSERVATION_FACT" 
   (	"ENCOUNTER_NUM" NUMBER(38,0), 
	"PATIENT_NUM" NUMBER(38,0), 
	"CONCEPT_CD" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"PROVIDER_ID" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"START_DATE" DATE, 
	"MODIFIER_CD" VARCHAR2(100 BYTE), 
	"VALTYPE_CD" VARCHAR2(50 BYTE), 
	"TVAL_CHAR" VARCHAR2(255 BYTE), 
	"NVAL_NUM" NUMBER(18,5), 
	"VALUEFLAG_CD" VARCHAR2(50 BYTE), 
	"QUANTITY_NUM" NUMBER(18,5), 
	"UNITS_CD" VARCHAR2(50 BYTE), 
	"END_DATE" DATE, 
	"LOCATION_CD" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"CONFIDENCE_NUM" NUMBER(18,0), 
	"UPDATE_DATE" DATE, 
	"DOWNLOAD_DATE" DATE, 
	"IMPORT_DATE" DATE, 
	"SOURCESYSTEM_CD" VARCHAR2(50 BYTE), 
	"UPLOAD_ID" NUMBER(38,0), 
	"OBSERVATION_BLOB" CLOB
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" 
 LOB ("OBSERVATION_BLOB") STORE AS BASICFILE (
  TABLESPACE "I2B2_DATA" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE NOLOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)) ;
 

  CREATE INDEX "I2B2DEMODATA"."IDX_OB_FACT_1" ON "I2B2DEMODATA"."OBSERVATION_FACT" ("CONCEPT_CD") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS COMPRESS 1 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 
  CREATE INDEX "I2B2DEMODATA"."IDX_OB_FACT_2" ON "I2B2DEMODATA"."OBSERVATION_FACT" ("CONCEPT_CD", "PATIENT_NUM", "ENCOUNTER_NUM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS COMPRESS 1 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 
  CREATE INDEX "I2B2DEMODATA"."IDX_OB_FACT_3" ON "I2B2DEMODATA"."OBSERVATION_FACT" ("PATIENT_NUM", "START_DATE", "CONCEPT_CD", "ENCOUNTER_NUM", "NVAL_NUM", "TVAL_CHAR", "VALTYPE_CD", "MODIFIER_CD", "VALUEFLAG_CD", "PROVIDER_ID", "QUANTITY_NUM", "UNITS_CD", "END_DATE", "LOCATION_CD", "CONFIDENCE_NUM", "UPDATE_DATE", "DOWNLOAD_DATE", "IMPORT_DATE", "SOURCESYSTEM_CD", "UPLOAD_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS COMPRESS 1 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 
  CREATE UNIQUE INDEX "I2B2DEMODATA"."OB_FACT_PK" ON "I2B2DEMODATA"."OBSERVATION_FACT" ("ENCOUNTER_NUM", "PATIENT_NUM", "CONCEPT_CD", "PROVIDER_ID", "START_DATE", "MODIFIER_CD") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 
  CREATE UNIQUE INDEX "I2B2DEMODATA"."SYS_IL0000073075C00021$$" ON "I2B2DEMODATA"."OBSERVATION_FACT" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
 

  CREATE TABLE "I2B2DEMODATA"."PATIENT_DIMENSION" 
   (	"PATIENT_NUM" NUMBER(38,0), 
	"VITAL_STATUS_CD" VARCHAR2(50 BYTE), 
	"BIRTH_DATE" DATE, 
	"DEATH_DATE" DATE, 
	"SEX_CD" VARCHAR2(50 BYTE), 
	"AGE_IN_YEARS_NUM" NUMBER(38,0), 
	"LANGUAGE_CD" VARCHAR2(50 BYTE), 
	"RACE_CD" VARCHAR2(50 BYTE), 
	"MARITAL_STATUS_CD" VARCHAR2(50 BYTE), 
	"RELIGION_CD" VARCHAR2(50 BYTE), 
	"ZIP_CD" VARCHAR2(50 BYTE), 
	"STATECITYZIP_PATH" VARCHAR2(700 BYTE), 
	"UPDATE_DATE" DATE, 
	"DOWNLOAD_DATE" DATE, 
	"IMPORT_DATE" DATE, 
	"SOURCESYSTEM_CD" VARCHAR2(50 BYTE), 
	"UPLOAD_ID" NUMBER(38,0), 
	"PATIENT_BLOB" CLOB
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" 
 LOB ("PATIENT_BLOB") STORE AS BASICFILE (
  TABLESPACE "I2B2_DATA" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE NOLOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)) ;
 

  CREATE TABLE "I2B2DEMODATA"."PATIENT_TRIAL" 
   (	"PATIENT_NUM" NUMBER, 
	"TRIAL" VARCHAR2(30 BYTE)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 
 
 
  CREATE TABLE "I2B2METADATA"."I2B2_TAGS" 
   (	"TAG_ID" NUMBER(18,0) NOT NULL ENABLE, 
	"PATH" NVARCHAR2(200), 
	"TAG" NVARCHAR2(200), 
	"TAG_TYPE" NVARCHAR2(200), 
	 CONSTRAINT "I2B2_TAGS_PK" PRIMARY KEY ("TAG_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA"  ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 

  CREATE TABLE "I2B2METADATA"."I2B2" 
   (	"C_HLEVEL" NUMBER(22,0), 
	"C_FULLNAME" VARCHAR2(900 BYTE) NOT NULL ENABLE, 
	"C_NAME" VARCHAR2(2000 BYTE), 
	"C_SYNONYM_CD" CHAR(1 BYTE), 
	"C_VISUALATTRIBUTES" CHAR(3 BYTE), 
	"C_TOTALNUM" NUMBER(22,0), 
	"C_BASECODE" VARCHAR2(450 BYTE), 
	"C_METADATAXML" CLOB, 
	"C_FACTTABLECOLUMN" VARCHAR2(50 BYTE), 
	"C_TABLENAME" VARCHAR2(50 BYTE), 
	"C_COLUMNNAME" VARCHAR2(50 BYTE), 
	"C_COLUMNDATATYPE" VARCHAR2(50 BYTE), 
	"C_OPERATOR" VARCHAR2(10 BYTE), 
	"C_DIMCODE" VARCHAR2(900 BYTE), 
	"C_COMMENT" CLOB, 
	"C_TOOLTIP" VARCHAR2(900 BYTE), 
	"UPDATE_DATE" DATE, 
	"DOWNLOAD_DATE" DATE, 
	"IMPORT_DATE" DATE, 
	"SOURCESYSTEM_CD" VARCHAR2(50 BYTE), 
	"VALUETYPE_CD" VARCHAR2(50 BYTE)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" 
 LOB ("C_METADATAXML") STORE AS BASICFILE (
  TABLESPACE "I2B2_DATA" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE NOLOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)) 
 LOB ("C_COMMENT") STORE AS BASICFILE (
  TABLESPACE "I2B2_DATA" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE NOLOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)) ;
 

  CREATE INDEX "I2B2METADATA"."IDX_I2B2_A" ON "I2B2METADATA"."I2B2" ("C_FULLNAME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS COMPRESS 1 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 
  CREATE INDEX "I2B2METADATA"."IDX_I2B2_B" ON "I2B2METADATA"."I2B2" ("C_BASECODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS COMPRESS 1 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 
  CREATE UNIQUE INDEX "I2B2METADATA"."SYS_IL0000073067C00008$$" ON "I2B2METADATA"."I2B2" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
 
  CREATE UNIQUE INDEX "I2B2METADATA"."SYS_IL0000073067C00015$$" ON "I2B2METADATA"."I2B2" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
 

  CREATE TABLE "I2B2METADATA"."I2B2_SECURE" 
   (	"C_HLEVEL" NUMBER(22,0), 
	"C_FULLNAME" VARCHAR2(900 BYTE) NOT NULL ENABLE, 
	"C_NAME" VARCHAR2(2000 BYTE), 
	"C_SYNONYM_CD" CHAR(1 BYTE), 
	"C_VISUALATTRIBUTES" CHAR(3 BYTE), 
	"C_TOTALNUM" NUMBER(22,0), 
	"C_BASECODE" VARCHAR2(450 BYTE), 
	"C_METADATAXML" CLOB, 
	"C_FACTTABLECOLUMN" VARCHAR2(50 BYTE), 
	"C_TABLENAME" VARCHAR2(50 BYTE), 
	"C_COLUMNNAME" VARCHAR2(50 BYTE), 
	"C_COLUMNDATATYPE" VARCHAR2(50 BYTE), 
	"C_OPERATOR" VARCHAR2(10 BYTE), 
	"C_DIMCODE" VARCHAR2(900 BYTE), 
	"C_COMMENT" CLOB, 
	"C_TOOLTIP" VARCHAR2(900 BYTE), 
	"UPDATE_DATE" DATE, 
	"DOWNLOAD_DATE" DATE, 
	"IMPORT_DATE" DATE, 
	"SOURCESYSTEM_CD" VARCHAR2(50 BYTE), 
	"VALUETYPE_CD" VARCHAR2(50 BYTE), 
	"SECURE_OBJ_TOKEN" VARCHAR2(50 BYTE)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" 
 LOB ("C_METADATAXML") STORE AS BASICFILE (
  TABLESPACE "I2B2_DATA" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE NOLOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)) 
 LOB ("C_COMMENT") STORE AS BASICFILE (
  TABLESPACE "I2B2_DATA" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE NOLOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)) ;
 

  CREATE INDEX "I2B2METADATA"."I2B2_SECURE_CD_IDX" ON "I2B2METADATA"."I2B2_SECURE" ("C_BASECODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" ;
 
  CREATE UNIQUE INDEX "I2B2METADATA"."SYS_IL0000073081C00008$$" ON "I2B2METADATA"."I2B2_SECURE" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
 
  CREATE UNIQUE INDEX "I2B2METADATA"."SYS_IL0000073081C00015$$" ON "I2B2METADATA"."I2B2_SECURE" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "I2B2_DATA" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
 
