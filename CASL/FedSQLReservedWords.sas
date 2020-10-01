/*Start as session called CASAUTO (default)and add calculation metrics to the log*/
cas mySess sessopts=(metrics=true);

/*Display CASLIBs in the left panel of SAS Studio*/
caslib _all_ assign;

/*Define three macro variables*/
%let variable=Make;
%let tovalue=Z;
%let fromvalue=A;

/*Move data from disk to memory.  Note: Please use proc casutil for moving your data.
  We are just doing the datastep for quick*/
data casuser.cars;
  set sashelp.cars;
run;

/*Translate is a reserved word; to use the translate functon, place "" around translate to escape the reserved word.
  However, if you put "" around a macro, it will escape the & as well.  Therefore, you must use the %tsslitmacro to 
  enclose the macro is the function requires double quotes around it.*/
proc fedsql sessref=casauto;
  create table casuser.examine{options replace=true} as
  select "translate"(&variable., %tslit(&tovalue), %tslit(&fromvalue)) as Make
  from casuser.cars;
quit;

/*End the cas session to free up resources for other users*/
cas mySess terminate;
