/*Start a cas session called mySess and add calculation metrics to the log*/
cas mySess sessopts=(metrics=true);

/*Add a local caslib with*/
caslib sasmem path='/Local_Files' datasource=(srctype='path');

/*Display the caslibs on the left most pane*/
caslib _all_ assign;

/*Add a workspace libname*/
libname sasdata '/Local_Files';

/*There is a CSV file called cars_out sitting in the path tied to sasmem that we want to
  parallel load and compressed in one pass.  Even though it uses the index action, it will
  not create an index.  This works with other files types as well */

/*I've set replications=0.  This frees memory and reduced I/O.  The cost is if a server goes down,
  the data has to be reloaded.  If you plan to persist data in-memory, then it might be best to set
  replication=1*/
proc cas;
  index /
    table={caslib="sasmem" name="cars_out.csv" singlepass=true}
    casout={caslib="sasmem" name="cars_compressed" blockSize=536870912 compress=true replication=0} ;
run;
quit;

/*Use proc contents to confirm it is compressed*/
proc contents data=sasmem.cars_compressed;
run;

cas mySess terminate;