/*----------------------------------------------------------------------
Name:       CourseQueryAction.cls
Purpose:    Query Course__c record
------------------------------History----------------------------------
Version     Author              Date                        Detail Description 
-------     --------------      -----------------           ------------------
1.0         Muhammad Abrar      10-September-2018           Initial Development 
----------------------------------------------------------------------*/
public with sharing class CourseQueryAction{

    public class CourseInput {
        @InvocableVariable(required=true)
        public Institution__c institutionRecord;
    }   

    /*----------------------------------------------------------------------
    Purpose:    Query Course__c record
    Parameters: CourseInput
    Returns:    Course__c
    ------------------------------History----------------------------------
    Version     Author              Date                        Detail Description 
    -------     --------------      -----------------           ------------------
    1.0         Muhammad Abrar      10-September-2018           Initial Development
    ----------------------------------------------------------------------*/
    @InvocableMethod(label='Get Course Names' description='Returns the list of course names.')
    public static List<List<Course__c>> getCourses(List<CourseInput> inputs) {
        List<List<Course__c>> lstBulkCourses = new List<List<Course__c>>();

        Set<Id> setUniqueInstitutionIds = new Set<Id>();
        for(CourseInput input : inputs){
            setUniqueInstitutionIds.add(input.institutionRecord.Id);
        }
        
        List<Course__c> lstCourses = new List<Course__c>();
        for (Course__c course : [SELECT Id, Name, Institution__c, Institution__r.Name, Duration__c, Frequency__c, Description__c FROM Course__c WHERE Institution__c IN :setUniqueInstitutionIds Order By Name ASC]) {
            lstCourses.add(course);
        }
        
        lstBulkCourses.add(lstCourses);
        
        return lstBulkCourses;
    }
    
}