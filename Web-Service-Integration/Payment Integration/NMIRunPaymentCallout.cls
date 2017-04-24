public class NMIRunPaymentCallout {

    private Lead lead;
    public double amountEachMonth {get; set;}
    public Integer amountOfPayments {get; set;}
    public String dayOfMonth {get; set;}
    public String monthFrequency {get; set;}
    public boolean isMonthFreq {get; set;}
    public String startDate {get; set;}
    public boolean isMonthToMonth {get; set;}
    public String planType {get; set;}
    
    public NMIRunPaymentCallout(ApexPages.StandardController ctl) {
        this.lead = [select FirstName, LastName, CC_Number__c, CC_Expiration__c, Total_Cost_for_Plan_VF__c, Email,
        Down_Payment__c, Amount_of_Payments__c, Monthly_Payment_Amount__c, Month_to_Month__c, CVV__c, Billing_Zip__c, 
        X1_Year_Plan__c, X3_Year_Plan__c, City, Street, State from Lead where id =:
        ApexPages.currentPage().getParameters().get('id')];
        
        amountEachMonth = this.lead.Monthly_Payment_Amount__c;
        amountOfPayments = this.lead.Amount_of_Payments__c != null ? this.lead.Amount_of_Payments__c.intValue() : null;
        }
    
    public PageReference sendPayment() {
    Http http;
    HttpRequest req = new HttpRequest();
    HttpResponse res = new HttpResponse();
    String endPoint;
    String downPaymentEndPoint;
    String subscriptionEndpoint;
    String billingType = checkBillingType();
    planType = checkPlanType();
    endPoint = 'https://secure.networkmerchants.com/api/transact.php?username=example&password=example' + 
                '&first_name=' + EncodingUtil.urlEncode(lead.FirstName, 'UTF-8') + '&last_name=' + EncodingUtil.urlEncode(lead.LastName, 'UTF-8') + '&ccnumber=' + 
                lead.CC_Number__c + '&ccexp=' + lead.CC_Expiration__c + '&cvv=' + lead.CVV__c +
                '&address1=' + EncodingUtil.urlEncode(lead.Street, 'UTF-8') + '&city=' + EncodingUtil.urlEncode(lead.City, 'UTF-8') + 
                '&state=' + lead.State + '&zip=' + lead.Billing_Zip__c +
                '&email=' + lead.Email;
        
    if(billingType == 'Full Pay')
    {
        endPoint += '&type=sale';
        endPoint +='&amount=' + lead.Total_Cost_for_Plan_VF__c;
        endPoint += '&customer_receipt=true';
        req.setMethod('POST');
        req.setEndpoint(endPoint);
        System.debug(endPoint);
        res = runPayment(req);
    }
    else if (billingType == 'Monthly')
    {
        startDate = formatDate(startDate);
        downPaymentEndPoint = endPoint;
        downPaymentEndPoint += '&type=sale';
        downPaymentEndPoint += '&amount=' + lead.Down_Payment__c;
        downPaymentEndPoint += '&customer_receipt=true';
        req.setMethod('POST');
        req.setEndpoint(downPaymentEndPoint);
        System.debug(downPaymentEndPoint);
        res = runPayment(req);
        boolean goodResponse = res.getBody().toLowerCase().contains('response=1');
        subscriptionEndPoint = endPoint;
        subscriptionEndPoint += '&billing_method=recurring&recurring=add_subscription';     
        System.debug(goodResponse); 
        System.debug(subscriptionEndPoint);
            if (goodResponse && isMonthToMonth == true)
            {
                subscriptionEndPoint += '&plan_payments=0&plan_amount=' + lead.Monthly_Payment_Amount__c;
                subscriptionEndPoint += '&month_frequency=' + monthFrequency + '&day_of_month=' + dayOfMonth;
                subscriptionEndPoint += '&start_date=' + startDate;
                
             }     
             else if (goodResponse && isMonthToMonth == false)
             {
                subscriptionEndPoint += '&plan_payments=' + amountOfPayments + '&plan_amount=' + lead.Monthly_Payment_Amount__c;
                subscriptionEndPoint += '&start_date=' + startDate;        
                subscriptionEndPoint += '&month_frequency=' + monthFrequency + '&day_of_month=' + dayOfMonth;
             
             }   
        req.setEndpoint(subscriptionEndPoint);
        System.debug(subscriptionEndPoint);
        res = runPayment(req);
    }
        PageReference retUrl = new PageReference('/apex/NMIPaymentSuccess');
        boolean goodResponse = res.getBody().toLowerCase().contains('response=1');
        boolean isDeclined = res.getBody().toLowerCase().contains('decline');
        boolean isInvalidCard = res.getBody().toLowerCase().contains('invalid credit card');
        if (goodResponse)
        {
            retUrl = new PageReference('/apex/NMIPaymentSuccess');
            retUrl.setRedirect(true);
            return retUrl;
        }
        else if (isDeclined)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Payment failed to post. Definite cause - Card Declined'));
            return null;
        }   
        else if (isInvalidCard)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Payment failed to post. Definite cause - Invalid Card'));
            return null;    
        }
        else 
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Payment failed to post. Probable cause - Billing' +
            ' address not entered or formatted incorrectly.  Possible cause - Duplicate sale.  Alert your developer to check server logs.'));
            return null;    
        }  

}
    
    
    public String checkBillingType() {
        if (this.lead.Down_Payment__c != null && this.lead.Amount_of_Payments__c != null & this.lead.Monthly_Payment_Amount__c != null)
            return 'Monthly';
        if (this.lead.Month_to_Month__c == true)
            return 'Month to Month';
        else
            return 'Full Pay';
    }
    
    public String formatDate(String theDate) 
    {
      String startDate = theDate.replaceAll('\\/', '');
      String month = startDate.substring(0, 2);
      String day = startDate.substring(2, 4);
      String year = startDate.substring(4, 8);
      return year + month + day;
    }
    
    public String checkPlanType() 
    {
        if (this.lead.X1_Year_Plan__c)
            return '1 YEAR PLAN';
        else if (this.lead.X3_Year_Plan__c)
            return '3 YEAR PLAN';
        else
            return 'MONTH TO MONTH';
    
    }
    
    public HttpResponse runPayment(HttpRequest req)
    {
        Http http = new Http();
        HttpResponse res = new HttpResponse();
        res = http.send(req);
        System.debug(res.getBody());
        return res;
    }
}
