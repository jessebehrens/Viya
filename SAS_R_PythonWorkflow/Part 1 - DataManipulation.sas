/* Establish CAS session */
cas mysess;
caslib _all_ assign;

/*Delete old versions of tables created by this script*/
PROC CASUTIL;
   droptable casdata="READMIT_IMPUTED" incaslib="PUBLIC" quiet;
   droptable casdata="NEW_PATIENTS" incaslib="PUBLIC" quiet;
   droptable casdata="READMIT_PREP" incaslib="PUBLIC" quiet;
RUN;

/*Load SAS data set from a Base engine library to CAS*/
/*CAS Util is a Viya specific proc for working with tables in CAS*/
PROC CASUTIL;
	load data= READMIT.READMISSIONS_RAW outcaslib="PUBLIC" casout="READMISSIONS_RAW";
    load data= READMIT.NEW_PATIENTS outcaslib="PUBLIC" casout="NEW_PATIENTS" promote;
RUN;

/*Make the readmit flag a human readable binary variable and save it as a local table in a global library*/
/*FEDSQL runs across partitioned data*/

PROC FEDSQL sessref=mysess;
  create table PUBLIC.READMIT_PREP as
  select *,
  case when DV_READMIT_FLAG > 0 THEN 'Y'
    else 'N'
  end as READMIT
  from PUBLIC.READMISSIONS_RAW;
QUIT;

/*Delete PUBLIC.HOSPITAL_ADMISSIONS using PROC DATASETS*/

PROC DATASETS lib=public nodetails nolist nowarn;
  delete HOSPITAL_ADMISSIONS;
QUIT;

/*Partition with indicator 1=Training, 0=Validation*/
PROC PARTITION 	data=PUBLIC.READMIT_PREP samppct=70 partind seed=1985;
  by READMIT;
  output out=PUBLIC.READMIT_PART;
RUN;

/*Impute Missing Values*/
PROC VARIMPUTE data=PUBLIC.READMIT_PART;
	input ORDER_SET_USED LENGTH_OF_STAY CHRONIC_CONDITIONS_NUMBER PATIENT_AGE / ctech=median;
	output out=PUBLIC.READMIT_IMPUTED copyvar=(_all_);
	ods output varimputeinfo = varimputeinfo ;
RUN;

/*Promote table to access it from other sessions. The global table will persist after ending the session*/
PROC CASUTIL incaslib="PUBLIC" outcaslib="PUBLIC";   
   promote casdata="READMIT_IMPUTED";
QUIT;

/*End CAS session to remove local files and free up resources*/
cas mysess terminate;
