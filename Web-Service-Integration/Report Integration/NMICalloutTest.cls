@IsTest public with sharing class nmiCalloutTest {
  
  @IsTest(SeeAllData=true) static void fieldTester() {
      Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
      
      HttpResponse res = new nmiCallout().createReq();
      
          
    System.assertEquals("Your example server response", new nmiCallout().parseResponse(res));   
  }
}
