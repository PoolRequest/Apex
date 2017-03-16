public without sharing class YourPageController {
    ApexPages.StandardController controller;
    public YourPageController()
    {
    }
    public YourPageController(ApexPages.StandardController Controller)
    {
        container = (CopyOfObjectToUpdate__c)Controller.getRecord();
        this.controller = Controller;
    }
    public CopyOfObjectToUpdate getContainer() 
    {
        return container;
    }
    CopyOfObjectToUpdate__c container = new CopyOfObjectToUpdate__c();
    public double ExampleField {get; set;}
    public double ExampleField {get; set;}
    public double ExampleField {get; set;}
    public double ExampleField {get; set;}
    public String ExampleField {get; set;}
    
    public PageReference updateStandardObject() 
    {
        PageReference retUrl = new PageReference('www.your redirect on save here.com');
        retUrl.setRedirect(true);
        Case toUpdate = new Case();
        toUpdate.Technician_Diagnosis__c = container.ExampleField__c;
        toUpdate.Technician_Labor__c = container.ExampleField__c;
        toUpdate.Technician_Make__c = container.ExampleField__c;
        toUpdate.Technician_Model__c = container.ExampleField__c;
        toUpdate.Technician_Pricing__c  = container.ExampleField__c;
        toUpdate.Technician_Serial_No__c = container.ExampleField__c;
        toUpdate.Technician_Subtotal__c = container.Subtotal__c;
        // Id parameter is passed in url to visualforce page, i.e /apex/VFPage?id=recordIdHere
        toUpdate.Id = ApexPages.currentPage().getParameters().get('id');
        
        update toUpdate;
        return retUrl;
    }
}
