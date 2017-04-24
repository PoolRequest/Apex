@isTest (seeAllData=false)
private class NMIRunPaymentCalloutTest
{

static testMethod void buildLead() 
{
    Test.setMock(HttpCalloutMock.class, new NMIRunPaymentMockHttp());
    Lead monthlyLead = new Lead(
    FirstName = 'Zillow',
    LastName = 'Test',
    Company = 'Zach',
    Street = '1139 Brogdon Dr',
    City = 'Powder Springs',
    State = 'GA',
    PostalCode = '30127',
    Billing_Street__c = '1139 Brogdon Drive',
    Billing_City__c = 'Powder Springs',
    Billing_State__c = 'GA',
    Billing_Zip__c = '30127',
    Down_Payment__c = 150.00,
    Amount_Of_Payments__c = 18
    );
    insert monthlyLead;
    
    Lead fullPayLead = new Lead(
    FirstName = 'Zillow',
    LastName = 'Test',
    Company = 'Zach',
    Street = '1139 Brogdon Dr',
    City = 'Powder Springs',
    State = 'GA',
    PostalCode = '30127',
    Billing_Street__c = '1139 Brogdon Drive',
    Billing_City__c = 'Powder Springs',
    Billing_State__c = 'GA',
    Billing_Zip__c = '30127',
    Total_Cost_for_Plan_VF__c = 450.00
    );
    insert fullPayLead;
    
    Test.startTest();
    
    ApexPages.Standardcontroller scml = new ApexPages.Standardcontroller(monthlyLead);
    ApexPages.currentPage().getParameters().put('id', monthlyLead.Id);
    
    NMIRunPaymentCallout monthlyPay = new NMIRunPaymentCallout(scml);
    monthlyPay.amountOfPayments = 18;
    monthlyPay.amountEachMonth = 150.00;
    monthlyPay.dayOfMonth = '25';
    monthlyPay.isMonthFreq = true;
    monthlyPay.isMonthToMonth = false;
    monthlyPay.startDate = '04/04/2017';
    monthlyPay.sendPayment();
    
    ApexPages.Standardcontroller scfpl = new ApexPages.Standardcontroller(fullPayLead);
    ApexPages.currentPage().getParameters().put('id', fullPayLead.Id);   
    NMIRunPaymentCallout fullCall = new NMIRunPaymentCallout(scfpl);
    fullCall.sendPayment();
    
    Test.stopTest();
    }
}
