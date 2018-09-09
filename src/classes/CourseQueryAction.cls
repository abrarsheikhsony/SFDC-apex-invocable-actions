//
//
//
public with sharing class CourseQueryAction{

    public class CourseInput {
        @InvocableVariable(required=true)
        public Institution__c institutionRecord;
    }   

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
    
    /*
    @InvocableMethod(label='Get Course Names' description='Returns the list of course names.')
    public static List<CourseOutput> getCourses(List<CourseInput> inputs) {
        List<CourseOutput> results = new List<CourseOutput>();

        Set<Id> setUniqueInstitutionIds = new Set<Id>();
        for(CourseInput input : inputs){
            setUniqueInstitutionIds.add(input.institutionRecord.Id);
        }
        
        for (Course__c course : [SELECT Id, Name, Institution__c, Institution__r.Name, Duration__c, Frequency__c, Description__c FROM Course__c WHERE Institution__c IN :setUniqueInstitutionIds Order By Name ASC]) {
            CourseOutput output = new CourseOutput();
                output.courseRecord = course;
            results.add(output);
        }
        
        return results;
    }
    */
    
    /*
    @InvocableMethod(label='Get Course Names' description='Returns the list of course names.')
    public static List<List<Course__c>> getCourses(List<Id> lstInstitutionIds) {
        List<List<Course__c>> lstBulkCourses = new List<List<Course__c>>();
        
        List<Course__c> lstCourses = new List<Course__c>();
        for (Course__c course : [SELECT Id, Name, Institution__c, Institution__r.Name, Duration__c, Frequency__c, Description__c FROM Course__c WHERE Institution__c IN :lstInstitutionIds Order By Name ASC]) {
            lstCourses.add(course);
        }
        
        lstBulkCourses.add(lstCourses);
        
        return lstBulkCourses;
    }
    */
    
}