This is an example of posting to a web service using a REST API.  This is an extension class on a lead object and is invoked from a javascript button.
A visualforce page opens and loads up the values to be sent to the merchant server.  Depending on the sale type, only certain fields 
are visible to prevent confusion and ensure the correct information is being sent.  

The response code from the server is parsed and if an error code is returned, determine the cause and display that to the user. 
