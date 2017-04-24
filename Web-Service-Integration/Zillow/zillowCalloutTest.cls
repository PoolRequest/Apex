@isTest (seeAllData=false)
private class zillowQueryTest
{

static testMethod void createLead() 
  {
    Test.setMock(HttpCalloutMock.class, new zillowMockHttp());
    Lead lead = new Lead(
    FirstName = 'Zillow',
    LastName = 'Test',
    Company = 'Zach',
    Street = '1139 Brogdon Dr',
    City = 'Powder Springs',
    State = 'GA',
    PostalCode = '30127'
    );
    
    insert lead;
  }
}
