/*----------------------------------------------------------------------
Name:       InstitutionQueryAction.cls
Purpose:    Query Institution__c record
------------------------------History----------------------------------
Version     Author              Date                        Detail Description 
-------     --------------      -----------------           ------------------
1.0         Muhammad Abrar      10-September-2018           Initial Development 
----------------------------------------------------------------------*/
public with sharing class InstitutionQueryAction{

    /*----------------------------------------------------------------------
    Purpose:    Query Institution__c record
    Parameters: None
    Returns:    Institution__c
    ------------------------------History----------------------------------
    Version     Author              Date                        Detail Description 
    -------     --------------      -----------------           ------------------
    1.0         Muhammad Abrar      10-September-2018           Initial Development
    ----------------------------------------------------------------------*/
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