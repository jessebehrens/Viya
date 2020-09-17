# Viya
This repository focuses on showing different ways to leverage and maximize the use of the CAS engine in Viya 3.5.  Viya provides several entry points into its massively parallel engine, including SAS code, open-source APIS, and GUIs.  This repository focuses on the SAS Code and open-source APIs.  A major focus of the SAS Viya3.5 is to allow users to use familiar syntaxes such as libnames, data steps, and procs in CAS.  Viya also introduces a new scripting language called CASL that leveraging <a href='https://documentation.sas.com/?docsetId=pgmdiff&docsetTarget=p06ibhzb2bklaon1a86ili3wpil9.htm&docsetVersion=3.5&locale=en'>actions</a>.  There are four parts:
<ul>
<li>
CASL - Focuses on CAS actions that demonstrate ways to efficiently connect to data, load data, manipulate data, and model data. 
</li>
<li>
DeepNeuralNetworks -Build, train, and score Deep Neural Networks (DNN) including, but not limited too: fully connected layers, convolutional networks, and recurrent networks through python APIs.
</li>
<li>
SAS_R_PythonWorkflow - This is a three-part demo that shows how Viya unifies across different platforms.  
  <ul>
    <li> Part 1 shows data manipulation and imputation using SAS procs</li>
    <li> Part 2 shows R leveraging the data to build models in the MPP framework through <a href='https://github.com/sassoftware/R-swat'>R-SWAT</a> and score new data.</li>
    <li> Part 3 shows python using the model results to plot ROC curves in matplotlib</li>
  </ul>

  Since SAS, R, and Python have access to the same algorithms and data, and they will produce the same result regardless of what entry point is used into CAS.
</li>
<li>
Caslibs - A mechanism for connecting in-memory CAS spaces to database and filesystems.  This folder shows the different ways to create CASLIBs.
</li>

Please reach out if there are any additional examples you would like for me to add.  I welcome all feedback!