### Deep Neural Networks on the SAS Platform

The SAS platform can build, train, and score Deep Neural Networks (DNN) including, but not limited too: fully connected layers, convolutional networks, and recurrent networks.

SAS has two ways of programmingDNNs:
<ol>
<li><a href='https://go.documentation.sas.com/?cdcId=pgmsascdc&cdcVersion=9.4_3.4&docsetId=casdlpg&docsetTarget=cas-deeplearn-TblOfActions.htm&locale=en'>CAS actions</a></li>
<li><a href='https://github.com/sassoftware/python-dlpy'>DLPY</a></li>
</ol>

CAS Actions are the smallest unit of work for the CAS server.  This is a great explanation on <a href='https://developer.sas.com/apis/cas/actions.html'>CAS actions</a>.

The SAS DLPY packages allows users to build DNNS using a Keras-like API.  The models are built using the same engine os the CAS actions.  Great documentation can be found <a href='https://sassoftware.github.io/python-dlpy/'>here</a>.


Note: Sometimes github does not render Jupyter Notebooks correctly.  If that's the case, use the following link: https://nbviewer.jupyter.org
