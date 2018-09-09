/*----------------------------------------------------------------------
Name:       ContactQueryAction.cls
Purpose:    Query Contact record
------------------------------History----------------------------------
Version     Author              Date                        Detail Description 
-------     --------------      -----------------           ------------------
1.0         Muhammad Abrar      10-September-2018           Initial Development 
----------------------------------------------------------------------*/
public with sharing class ContactQueryAction{

    public class ContactInput {
        @InvocableVariable(required=true)
        public String contactEmailAddress;
    } 

    public class ContactOutput {
        @InvocableVariable(required=true)
        public Contact contactRecord;
    }

    /*----------------------------------------------------------------------
    Purpose:    Query Contact record
    Parameters: CourseInput
    Returns:    Course__c
    ------------------------------History----------------------------------
    Version     Author              Date                        Detail Description 
    -------     --------------      -----------------           ------------------
    1.0         Muhammad Abrar      10-September-2018           Initial Development
    ----------------------------------------------------------------------*/
    @InvocableMethod(label='Get Contact' description='Returns contact record.')
    public static List<ContactOutput> getCourses(List<ContactInput> inputs) {
        List<ContactOutput> lstContacts = new List<ContactOutput>();

        Set<String> setContactEmailAddresses = new Set<String>();
        for(ContactInput input : inputs){
            setContactEmailAddresses.add(input.contactEmailAddress);
        }

        for(Contact contactRecord : [SELECT Id, Name, Email, AccountId, Account.Name FROM Contact WHERE Email IN : setContactEmailAddresses]){
                                                    
            ContactOutput output = new ContactOutput();
            output.contactRecord = contactRecord;
            lstContacts.add(output);
        }        
        
        return lstContacts;
    }

}