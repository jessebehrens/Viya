# CASL
This repository contains code and examples of using <a href='https://documentation.sas.com/?docsetId=pgmdiff&docsetTarget=p06ibhzb2bklaon1a86ili3wpil9.htm&docsetVersion=3.5&locale=en'>CASL</a> to perform tasks, techniques, data manipulations, analytics, and efficient processing of data in SAS Viya's CAS engine.  The following code snippets include:

<ul>
<li>CASLTips.sas - This is a great script created by Robert Cohen of SAS.  It demonstrates:
    <ul>
       <li>The power of PROC CAS to execute SAS actions</li>
       <li>Viya enabled procs, such as regselect, as well as their action counterparts, to run distributed analytics in the CAS engine</li>
    </ul>
       
</li>
<li>
Formats.sas - Formats have to be available to the CAS engine.  If they are not, SAS will send the data back to the SAS9 engine to apply formats, killing any processing gains made with the CAS engine.  This script demonstrates how to load, create, move, and persist formats into CAS.
</li>
<li>
SaveCompressed.sas - Save in-memory table stored in a CASLIB back to disk as a <b>compressed</b> sas7bdat on disk
</li>
<li>
ParallelLoadandCompressData.sas - Parallel loads a file from a file location (path, database, etc.) to a CASLIB.  The data is compressed as it is loaded.
</li>
<li>
ConvertChartoVarchar.sas - Load a table into memory from disk and convert all char variables of a certain length (and longer) to a varchar with an equivalant length.
</ul>
