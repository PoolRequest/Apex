public with sharing class TechnicianController
{
    private ApexPages.StandardController controller;
    public String Name {get; set;}
    public String Contact_Name {get; set;}
    public String Contact_Phone {get; set;}
    public String Contact_Email {get; set;}
    public double Service_fee {get; set;}
    public double Hourly_Rate {get; set;}
    public String Type {get; set;}
    public String Cities_Serviced {get; set;}

    public TechnicianController() {

    }    
 
    Public Service_Tech__c tech = new Service_Tech__c();

    public TechnicianController(ApexPages.StandardController Controller)
    {
        tech = (Service_Tech__c)Controller.getRecord();
        this.controller = Controller;
    }
    public PageReference save() 
    {
        insert tech;
        return null;
    }
}
