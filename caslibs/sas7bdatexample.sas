/****************SAS 9.4 Example - Serial load only********************/
libname sasdisk '/sasdata/data';

/*******************************************Multinode PathLib - sas7bdat only*****************************************************/
/*The srctype must be set to path to do*/
caslib sasmem  path='/sasdata/data' datasource=(srctype='path');




/****************If you want to save cas data as a sas7bdat - casout needs the sas7bdat**************/
proc casutil;
  save casdata='testdata' incaslib='sasmem'  casout='testdata.sas7bdat' replace;
quit;
