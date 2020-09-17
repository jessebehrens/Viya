/*****************************SNOWFLAKE with ODBC 9.4*******************************************************************/

libname sfdb odbc complete="DRIVER={SnowflakeDSIIDriver};
SERVER=yourserver.snowflakecomputing.com;
WAREHOUSE=users_wh;
UID=UID;
PWD=PWD;
DATABASE=users_db;"
SCHEMA=JEBEHR
dbcommit=10000 autocommit=no
readbuff=200 insertbuff=200;

/*****************************SNOWFLAKE with ODBC Viya*******************************************************************/


caslib snowmem datasource=(srctype="odbc" uid="uid" pwd="pwd" schema='JEBEHR'  conopts="driver=SnowflakeDSIIDriver;
SERVER=yourserver.snowflakecomputing.com;WAREHOUSE=users_wh;DATABASE=users_db" dm_unicode="utf-16" ) ;


/*****************************SNOWFLAKE with JDBC 9.4*******************************************************************/
libname snowdisk jdbc driver='net.snowflake.client.jdbc.SnowflakeDriver'
          URL='jdbc:snowflake://yourserver.snowflakecomputing.com:443/?warehouse=users_wh&db=users_db&schema=JEBEHR' 
          uid="uid" pwd="pwd"
          classpath='/opt/sas/spre/home/lib64/accessclients/jdbc/snowflake/'
          LOGIN_TIMEOUT=0;

/*****************************SNOWFLAKE with JDBC Viya*******************************************************************/
caslib snowmem desc='Snowflake'
datasource=(srctype="jdbc",
uid="uid",
pwd="pwd",
URL='jdbc:snowflake://yourserver.snowflakecomputing.com:443/?warehouse=users_wh&db=users_db&schema=JEBEHR',
class='net.snowflake.client.jdbc.SnowflakeDriver', 
classPath='/opt/sas/viya/home/lib64/accessclients/jdbc/snowflake/');
