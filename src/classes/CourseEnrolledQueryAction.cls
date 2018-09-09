/*----------------------------------------------------------------------
Name:       CourseEnrolledQueryAction.cls
Purpose:    Query CourseEnrolled__c record
------------------------------History----------------------------------
Version     Author              Date                        Detail Description 
-------     --------------      -----------------           ------------------
1.0         Muhammad Abrar      10-September-2018           Initial Development 
----------------------------------------------------------------------*/
public with sharing class CourseEnrolledQueryAction{

    public class CourseEnrolledInput {
        @InvocableVariable(required=true)
        public String courseEnrolledID;
    } 

    public class CourseEnrolledOutput {
        @InvocableVariable(required=true)
        public CourseEnrolled__c courseEnrolRecord;
    }

    /*----------------------------------------------------------------------
    Purpose:    Query CourseEnrolled__c record
    Parameters: CourseEnrolledInput
    Returns:    CourseEnrolledOutput
    ------------------------------History----------------------------------
    Version     Author              Date                        Detail Description 
    -------     --------------      -----------------           ------------------
    1.0         Muhammad Abrar      10-September-2018           Initial Development
    ----------------------------------------------------------------------*/
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

}