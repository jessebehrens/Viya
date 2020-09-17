/*Start a cas session called mySess and add calculation metrics to the log*/
cas mySess sessopts=(metrics=true);

/*Add a local caslib with*/
caslib sasmem path='/Local_Files' datasource=(srctype='path');

/*Add a workspace libname*/
libname sasdata '/Local_Files';

/*Display CASLIBs in the right panel of SAS Studio*/
caslib _all_ assign;

/*We have an in-memory table called CARS in the caslib.CARS our goal is to save it back down
  as a sas7bdat down to disk located at /LocalFiles compressed!  If you need to see how to load
  data into CAS - please check the other code under CASL*/

/*PROC CASUTIL is the best way to move data from memory to disk, or vice versa.
  The incaslib lists the dataset that resides in memory.  The outcaslib points to 
  location we want to save the actual file. casdata is the in-memory dataset, and
  casout is the name it will use on disk.  You must include the .sas7bdat.
  The request for compression happens in export options, as well dmsglvli
  giving us more information in the log;*/

proc casutil incaslib='casuser' outcaslib='sasmem';
   save casdata='cars' casout='cars_compress.sas7bdat'
   exportoptions=(filetype='basesas', compress='yes', debug='dmsglvli') replace ;
run;
quit;

/*Let's verify that it is infact compressed*/
proc contents data=sasdata.cars_compress;
run;

/*End the cas session to free up resources for other users*/
cas mySess terminate;