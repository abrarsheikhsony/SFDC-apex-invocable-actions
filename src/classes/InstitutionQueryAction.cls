//
//
//
public with sharing class InstitutionQueryAction{

    @InvocableMethod(label='Get Institution Names' description='Returns the list of institution names.')
    public static List<List<Institution__c>> getInstitutions() {
        List<List<Institution__c>> lstBulkInstitutions = new List<List<Institution__c>>();
        
        List<Institution__c> lstInstitutions = new List<Institution__c>();
        for (Institution__c institution : [SELECT Id, Name FROM Institution__c Order By Name ASC]) {
            lstInstitutions.add(institution);
        }
        
        lstBulkInstitutions.add(lstInstitutions);
        
        return lstBulkInstitutions;
    }
    
}