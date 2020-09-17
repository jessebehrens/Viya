# CASL
This repository contains code and examples of using <a href='https://documentation.sas.com/?docsetId=pgmdiff&docsetTarget=p06ibhzb2bklaon1a86ili3wpil9.htm&docsetVersion=3.5&locale=en'>CASL</a> to perform tasks, techiquies, data manipulations, analytics, and efficent processing of data in SAS Viya's CAS engine.  The following code snippets include:

<ul>
<li>CASLTips.sas - This is a great script created by Robert Cohen of SAS.  It demonstrates:
    <li>The power of PROC CAS to execute SAS actions</li>
    <li>Viya enabled procs, such as regselect, as well their action counter parts, to run distributed analytics in the CAS engine</li>
</li>
<li>
Formats.sas - Formats have to be available to the CAS engine.  If they are not, SAS will send out the data back to the SAS9 engine to apply formats essentially killing any processing gains made with the CAS engine.  This script demonstrates how to load, create, move, and persist formats into CAS.
</li>
</ul>
