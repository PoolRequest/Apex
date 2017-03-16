To preface, this workaround is not ideal and is only to be used as a last resort.

What your organization asks you to do:
Create a Force.com visualforce page that will allow Guest Site Users to read and edit select fields from their own Account/Case/Contact.

The Problem: 
Salesforce does not allow Guest Site Users permission to edit standard objects like Account/Case/Contact.  You must purchase a special
license and authenticate them.

The Solution:
Create an identical dummy object with only the select fields that need to be accessed.  Show these fields on the visualforce page and
use them in your controller to locate and update the case object.
