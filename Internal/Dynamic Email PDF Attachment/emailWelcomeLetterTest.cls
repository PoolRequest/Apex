@IsTest(seeAllData=false)
private class emailWelcomeLetterTest
{
    public static String first;
    public static String last;
    public static String email;
    public static boolean isSold;
    public static String company;
    
static testMethod void createLead()
    {     
        List<Lead> leads = new List<Lead>();
        leads.add(new Lead(
            FirstName = 'Zach',
            LastName = 'Butts',
            Email = 'zach@afchomeclub.com',
            Temp_Is_Sold_Bool__c = false,
            Company = 'Jimbo'
        ));
        insert leads;
        
        Lead createdLead = leads.get(0);
        List<Attachment> att = new List<Attachment>();
        att.add(new Attachment(        
        Name = 'Test.txt',
        Body = Blob.valueOf('Just test content'),
        parentId = createdLead.Id
        ));
        insert att;
        
        Lead fetchLead = [select Id, Temp_Is_Sold_Bool__c from Lead where FirstName = 'Zach'];
        fetchLead.Temp_Is_Sold_Bool__c = true;
        update fetchLead;   
        fetchLead.Temp_Is_Sold_Bool__c = false;
        update fetchLead;
    } 
}
