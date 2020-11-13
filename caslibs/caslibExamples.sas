/****************************************************************************************************************************************************\
CASLIBs are methods for tying file locations, such as databases, filesystems, object storage, etc. to an in-memory space in CAS.  They provide a 
mechanism for loading data from disk into memory, often in a parallel manner.  Be aware, CASLIBS will only display what has been loaded into memory
when you check the contents of a CASLIB.  There are methods for listing the files on a database/filesytem that we will demonstrate below.
\*****************************************************************************************************************************************************/

/*Create a CASLIB to a location on disk.  This can read SAS7BDATs, CSVs, other file types, often in parallel.  Replace the '/sasdata/data' with your path*/  
caslib sasmem  path='/sasdata/data' datasource=(srctype='path');

/*Create a CAS connection to a redshift database.  The numreadnodes=0 and numwritenodes=0 tells CAS to use all worker nodes to read
  and write the data from/to a database.*/  

caslib rsmem datasource=(srctype="redshift", user='user', password="password", schema="schema", port=5439, database="sas",
                         server="yourserver.ckdcmehzvrkl.us-east-1.redshift.amazonaws.com", numwritenodes=0, numreadnodes=0); 

/*Create a CAS connection to snowflake.  Instead of passing the password and username directly into code use an authdomain.  The 
  authdomain will pass the credentials*/

caslib snowcas   desc='Snowflake Caslib' 
     dataSource=(srctype='snowflake'
                 server='your.snowflakecomputing.com'
                 schema='schema'
                 authdomain='Authdomain'
                 database="USERS_DB");
caslib _all_ assign;

/*To list the files in the datasource tied to a CASLIB that live on disk or in a databased, use proc casutil*/

proc casutil incaslib='snowcas';
  list files;
quit;
