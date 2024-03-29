# CASL
This repository contains code and examples of using <a href='https://documentation.sas.com/?docsetId=pgmdiff&docsetTarget=p06ibhzb2bklaon1a86ili3wpil9.htm&docsetVersion=3.5&locale=en'>CASL</a> to perform tasks, techniques, data manipulations, analytics, and efficient processing of data in SAS Viya's CAS engine.  The following code snippets include:

<ul>
    <li><b>CASLTips.sas</b> - This is a great script created by Robert Cohen of SAS.  It demonstrates:
    <ul>
       <li>The power of PROC CAS to execute SAS actions</li>
       <li>Viya enabled procs, such as regselect, as well as their action counterparts, to run distributed analytics in the CAS engine</li>
    </ul>
<li>
    <b>FedSQLReservedWords.sas</b> - <a href='https://go.documentation.sas.com/?cdcId=pgmsascdc&cdcVersion=9.4_3.5&docsetId=casfedsql&docsetTarget=titlepage.htm&locale=en'>Proc FedSQL</a> is used for executing structured query language against CAS tables.  FedSQL has quite a few <a href='https://go.documentation.sas.com/?cdcId=pgmsascdc&cdcVersion=9.4_3.5&docsetId=casfedsql&docsetTarget=p1gp2oyo2wxjmun1a9de92k57d91.htm&locale=en'>reserved words</a> that cannot be used in open code.  Therefore, reserved words need to be escaped by placing them in double quotes.  In the case of macros that require double quotes to resolve, use the <a href='https://go.documentation.sas.com/?docsetId=lebaseutilref&docsetTarget=n1phgnraoodvpln1bm941n44yq7q.htm&docsetVersion=9.4&locale=en'>%tslit</a> macro instead of double quotes.
</li>
<li>
    <b>Formats.sas</b> - Formats have to be available to the CAS engine.  If they are not, SAS will send the data back to the SAS9 engine to apply formats, killing any processing gains made with the CAS engine.  This script demonstrates how to load, create, move, and persist formats into CAS.
</li>
<li>
    <b>SaveCompressed.sas</b> - Save in-memory table stored in a CASLIB back to disk as a <b>compressed</b> sas7bdat on disk
</li>
<li>
    <b>ParallelLoadandCompressData.sas</b> - Parallel loads a file from a file location (path, database, etc.) to a CASLIB.  The data is compressed as it is loaded.
</li>
<li>
    <b>ConvertChartoVarchar.sas</b> - Load a table into memory from disk and convert all char variables of a certain length (and longer) to a varchar with an equivalant length.
</ul>
