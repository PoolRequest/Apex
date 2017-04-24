This is an example of a web service being called by a trigger, specifically after a lead is inserted.  Since Salesforce cannot wait
for a webservice to complete to continue with DML statements, the trigger is written using a @future annotation.  This means the trigger
will run asynchronously, allowing Salesforce to continue performing database operations. 

The information derived from the reponse of the web service is loaded into the newly inserted object.
