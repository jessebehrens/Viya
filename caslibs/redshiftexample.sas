
/************************************SAS 9.4 Example*********************************************************
libname rsdisk redshift server='yourname.ckdcmehzvrkl.us-east-1.redshift.amazonaws.com' db=sas user=user pwd=pwd port=5439
                        schema='hlsanalytics';


/***Creates a caslib called rsmem and will do multinode read and write***/

caslib rsmem datasource=(srctype="redshift", user='user', password="password", schema="hlsanalytics", port=5439, database="sas",
                         server="yourserver.ckdcmehzvrkl.us-east-1.redshift.amazonaws.com", numwritenodes=0, numreadnodes=0) 
             libref=rsmem; 
