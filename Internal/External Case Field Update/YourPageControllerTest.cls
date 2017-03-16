@isTest (seeAllData=false)
private class YourPageControllerTest
{
    static testMethod void createFakeObject() 
    {
    // Create case object that we will update.
        Case fakeCase = new Case(
            Case_Reasons__c = 'Review for Valid Claim',
            Appliance_System__c = 'Gas',
            Status = 'New'
        );
        insert fakeCase;
        
        YourPageController testCtl = new YourPageController();  
        
        // Create object to fill with values that we will copy to fakeCase.
        CopyOfObjectToUpdate__c fake = new CopyOfObjectToUpdate__c();
        
        testCtl.Field = 300;
        testCtl.Field = '100';
        testCtl.Field = 200;
        testCtl.Field = 100;
        testCtl.Field = 200;
        testCtl.Field = 10;
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(fake);
        
        // Passing our fakeCase id into the session to replicate our getParameters.get();
        ApexPages.currentPage().getParameters().put('id', fakeCase.Id);
        
        TechnicianFieldController ctl = new TechnicianFieldController(sc);
        UsableTechFields__c faker = ctl.getContainer();

        ctl.updateCase();
        
    }
}
