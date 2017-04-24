This is an example of a using Apex to do what Salesforce cannot do out of the box. Workflow email alerts do not allow dynamic email attachments so 
this is a trigger that will fire after a formula field checkbox is set to true by meeting certain criteria.  A file is attached to the record which
will be automatically emailed to the email on the record.  

When the trigger fires, a <List>Attachment is created from the object that triggered.  If the list is empty the trigger skips.  The email
is built and sent using Salesforce's built in email classes.
