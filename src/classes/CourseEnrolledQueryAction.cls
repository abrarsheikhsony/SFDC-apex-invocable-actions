//
//
//
public with sharing class CourseEnrolledQueryAction{

    public class CourseEnrolledInput {
        @InvocableVariable(required=true)
        public String courseEnrolledID;
    } 

    public class CourseEnrolledOutput {
        @InvocableVariable(required=true)
        public CourseEnrolled__c courseEnrolRecord;
    } 

    @InvocableMethod(label='Get Course Enrol' description='Returns course enrol record.')
    public static List<CourseEnrolledOutput> getCourses(List<CourseEnrolledInput> inputs) {
        List<CourseEnrolledOutput> lstCourseEnrolls = new List<CourseEnrolledOutput>();

        Set<String> setCourseEnrolIds = new Set<String>();
        for(CourseEnrolledInput input : inputs){
            setCourseEnrolIds.add(input.courseEnrolledID);
        }

        for(CourseEnrolled__c courseEnrol : [SELECT Id, Name, Account__c, Contact__c,
                                                Course__c, Course__r.Name, Course__r.Description__c, Course__r.Duration__c, Course__r.Frequency__c, Course__r.Institution__r.Name,
                                                StartDate__c, EndDate__c, Location__c FROM CourseEnrolled__c WHERE Name IN : setCourseEnrolIds]){
                                                    
            CourseEnrolledOutput output = new CourseEnrolledOutput();
            output.courseEnrolRecord = courseEnrol;
            lstCourseEnrolls.add(output);
        }        
        
        return lstCourseEnrolls;
    }
    
    /*
    @InvocableMethod(label='Get Course Enrol' description='Returns course enrol record.')
    public static List<List<CourseEnrolled__c>> getCourses(List<CourseEnrolledInput> inputs) {
        List<List<CourseEnrolled__c>> lstBulkCourseEnrolls = new List<List<CourseEnrolled__c>>();

        Set<Id> setCourseEnrolIds = new Set<Id>();
        for(CourseEnrolledInput input : inputs){
            setCourseEnrolIds.add(input.courseEnrolledID);
        }
        
        List<CourseEnrolled__c> lstCourseEnrolls = new List<CourseEnrolled__c>();
                                                       
        for (CourseEnrolled__c courseEnrol : [SELECT Id, Name, Account__c, Contact__c,
                                                Course__c, Course__r.Name, Course__r.Description__c, Course__r.Duration__c, Course__r.Frequency__c, Course__r.Institution__r.Name,
                                                StartDate__c, EndDate__c, Location__c FROM CourseEnrolled__c WHERE Name IN : setCourseEnrolIds]) {
            lstCourseEnrolls.add(courseEnrol);
        }
        
        lstBulkCourseEnrolls.add(lstCourseEnrolls);
        
        return lstBulkCourseEnrolls;
    }
    */

}