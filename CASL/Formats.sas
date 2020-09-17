/*Start a CAS session*/
cas;
caslib _all_ assign;

/*List the CAS Format Libraries that exist*/
cas casauto listformats; 

/*Move cars to work*/
data cars;
  set sashelp.cars;
run;

/*Create a SAS9 format in the work library and create a copy in a CAS FORMAT Library.  The formats need to reside in both
  engines to be access by SAS9 and CAS.  The casfmtlib= puts the formats in a CASFormats Library called 'casformats'.  This
  will also create the cas format library casformats, that is it doesn't need to exist already*/

proc format library=work.formats casfmtlib="casformats" ;
   value enginesize
   low - <2.7 = "Very economical"
   2.7 - <4.1 = "Small"
   4.1 - <5.5 = "Medium"
   5.5 - <6.9 = "Large"
   6.9 - high = "Very large";
run;

/*List the CAS Format Libraries that exist - casformats has been created*/
cas casauto listformats;

/*Promote the formats library.  Promoted libraries will persist after the CAS sessions has ended for future use without having to reupload the formats.
  It also allows other users to access the formats*/
cas casauto promotefmtlib fmtlibname='casformats';

/*Global libraries are not automatically added to the format search list.  We can add it.  The position= specified where in the search path the new formats go
  Note: A global and session scope casformat library cannot have have the same name in the fmtsearch. Either we need to drop the session scoped formats,
  or rename the global formats.  In this example, I've not added global to the fmtsearch - but I show you how.*/
cas casauto listformats scope=global; 
/*cas casauto fmtsearch=(casformats) position=insert;*/
cas casauto listfmtsearch;                         


/*We now have a local and global copy.  If our CAS session was to end now - the global copy would stay*/
cas casauto listformats;

/*We may want to save a SASHDAT copy of the formats incase the server gets restarted, or an open source users wants to access formats. Additionally, if our
  server restarts - we can have .sashdat files autoload the formats back into memory: Here is the documentation for autoloading formats:
  https://go.documentation.sas.com/?docsetId=caldatamgmtcas&docsetTarget=n0jtz261h5qtg7n1j6ql02gd65lo.htm&docsetVersion=3.5&locale=en#p1xlmcq5h0yjuen1t7lgqf70nypy*/

/*Save the format to formats.casfmt_table.sashdat.  If you do not have a formats caslib, then any caslib will suffice */
cas casauto savefmtlib fmtlibname='casformats' caslib='formats' table='casfmt_table' replace;

/*Confirm formats.casfmt_table exists*/
proc casutil incaslib='formats';
  list files;
quit;

/*Create a mirror of cars, called cars_cas in the CASUSER caslib.  Additionally, we can apply the enginesize format created earlier*/

DATA casuser.cars_cas(replace=yes);
  set sashelp.cars;
  format enginesize enginesize.;
run;

/*The formats print!*/
proc print data=casuser.cars_cas(obs=10);
var EngineSize;
run;

/*List the CAS Format Libraries that exist*/
cas casauto listformats; 


/*Delete the session format library and remove it from the format search*/
cas casauto dropfmtlib fmtlibname=CASFORMATS fmtsearchremove;

/*List the CAS Format Libraries that exist - only the global format exists*/
cas casauto listformats; 

/*Delete the global format library - Since fmtsearchremove was applied early*/

cas casauto dropfmtlib fmtlibname=CASFORMATS;

/*List the CAS Format Libraries that exist.  The enginesize format no longer exists*/
cas casauto listformats; 

/*Load the format from the previously created SASHDAT*/
cas casauto addfmtlib fmtlibname=fmthdat caslib=formats table=casfmt_table;

/*List the CAS Format Libraries that exist.  Enginzesize is back!*/
cas casauto listformats; 

/*list fhe formate values in the new format library*/
cas casauto listformats members;
cas casauto listfmtranges fmtname=enginesize;   

/*The same formats apply with the SASHDAT!*/
DATA casuser.cars_cas(replace=yes);
  set sashelp.cars;
  format enginesize enginesize.;
run;


cas casauto terminate;
