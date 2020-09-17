/*This code converts all character data of a certain length or longer into VARCHAR as it's loaded from
  disk into memory.  Varchar can help reduce the size of data*/

/*Start a cas session called mySess and add calculation metrics to the log*/
cas mySess sessopts=(metrics=true);

/*Add a local caslib with*/
caslib sasmem path='/Local_Files' datasource=(srctype='path');

/* Binds all CAS librefs and default CASLIBs to your SAS client */
caslib _all_ assign;

/*Add a workspace libname*/
libname sasdata '/Local_Files';

/*Create a sas7bdat on disk that has different length character variables*/

data sasdata.table_with_char;
   length a $ 300 b $ 15 c $ 16;

   a='a300'; b='b15' ; c='c16' ; 
   output;
   a='a300300'; b='b151515'; c='c161616'; 
   output;
  
   c='c161616161616161'; 
   b='b15151515151515';
   a="a300qzwsxedcrfvtgbyhnujmiklopqazwsxedcrfvtgbyhnujmikolp12345678901234567890123456789012345678901234567890123456789012345678901234567890"; 
   output;
run;

/*Use proc contents to confirm the lengths of the variable on the in-memory data*/

proc contents data=sasdata.table_with_char;
run;

/*Use proc casutil to load the data in parallel.  The varcharconverion=16 states that any character of length 16
  or greater will be converted to a varch of the equivalant length.  The data is read from the path associated
  with the sasmem CASLIB and stored in the in-memory in the sasmem CASLIB.*/

proc casutil incaslib="sasmem" outcaslib="casuser";
  load casdata="table_with_char.sas7bdat" 
  casout="table_with_varchar" importoptions=(filetype="basesas" varcharconversion=16) replace;
run;

/*Confirm that the in-memory table has variables of char(16) or longer converted to varchar(16+)*/
proc contents data=casuser.table_with_varchar;
run;

/*End CAS session to release resources back to server*/
cas mySess terminate;

