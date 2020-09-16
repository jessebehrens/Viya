## Integrated Platform
This repository contains both code and data that demonstrate how SAS Viya enables an integrated advanced analytics platform across a set of users and tools.

#### Data
The data folder provides the data used to execute this demo.  The data is provided in both sas7bdat format as well as csv. There are two datasets:
<ol>
<li>readmissions_raw</li>
<li>new_patients</li>
</ol>

Readmissions_raw is the input dataset that feeds into Part1 - Data Manipulation.sas.  New_patients feeds into Part 3 - Exploring and Scoring the in Python.ipynb when the user is ready to score their champion model.

#### Part 1 - Data Manipulation.sas
The demo starts with Part 1 where a user has an input dataset, readmissions_raw, and they make some modifications to the dataset to prep it for modeling.  This includes: <ol>
  <li>Creating a Y/N flag</li>
  <li>Imputing missing values for multiple variables</li>
  </ol>
  
  Once the user is done, they promote their final data to be consumed by their team members.

#### Part 2 - Modeling the Data in R.ipynb
The demo continues with Part 2 where an R user picks up the results from Part 1 without ANY movement of the data.  The user can continue as if the original work was done in R.  In this program:<ol>
  <li>A correlation plot is calculated using both R and VIya</li>
  <li>A gradient boosting model is built</li>
  <li>A neural network model is built</li>
  </ol>
The resulting datasets, assessment metrics, and scoring files are promoted for other users to access

#### Part 3 - Exploring and Scoring the in Python.ipynb
The final phase is a Python user picking up the modeling results and determing which model best predicts readmissions.  The user assesses multiple aspects of the results including:<ol>
  <li>Confusion Matrices of both models</li>
  <li>ROC plot of both models overlaid into the same graph</li>
  
After the gradient boosting model is selected as the champion as their model of preference, the Python users applied the scoring algorithm to the production data, new_patients.
