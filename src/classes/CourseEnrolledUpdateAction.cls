/*----------------------------------------------------------------------
Name:       CourseEnrolledUpdateAction.cls
Purpose:    Update CourseEnrolled__c record
------------------------------History----------------------------------
Version     Author              Date                        Detail Description 
-------     --------------      -----------------           ------------------
1.0         Muhammad Abrar      10-September-2018           Initial Development 
----------------------------------------------------------------------*/
public with sharing class CourseEnrolledUpdateAction{

    public class CourseEnrolledInput {
        @InvocableVariable(required=true)
        public String courseEnrolledNumber;

        @InvocableVariable(required=true)
        public String newLocation;
    } 

    public class CourseEnrolledOutput {
        @InvocableVariable(required=true)
        public CourseEnrolled__c courseEnrolRecord;
    }
    
    /*----------------------------------------------------------------------
    Purpose:    Update CourseEnrolled__c record
    Parameters: CourseEnrolledInput
    Returns:    CourseEnrolledOutput
    ------------------------------History----------------------------------
    Version     Author              Date                        Detail Description 
    -------     --------------      -----------------           ------------------
    1.0         Muhammad Abrar      10-September-2018           Initial Development
    ----------------------------------------------------------------------*/
    @InvocableMethod(label='Update Course Enrol' description='Update course enrol record.')
    public static List<CourseEnrolledOutput> getCourses(List<CourseEnrolledInput> inputs) {
        List<CourseEnrolledOutput> lstCourseEnrolls = new List<CourseEnrolledOutput>();

        Map<String, String> mapEnrolNumberANDLocation = new Map<String, String>();
        for(CourseEnrolledInput input : inputs){
            mapEnrolNumberANDLocation.put(input.courseEnrolledNumber, input.newLocation);
        }

        for(CourseEnrolled__c courseEnroll : [SELECT Id, Name, Account__c, Contact__c,
                                                Course__c, Course__r.Name, Course__r.Description__c, Course__r.Duration__c, Course__r.Frequency__c, Course__r.Institution__r.Name,
                                                StartDate__c, EndDate__c, Location__c FROM CourseEnrolled__c WHERE Name IN : mapEnrolNumberANDLocation.keySet()]){
    
            courseEnroll.Location__c = mapEnrolNumberANDLocation.get(courseEnroll.Name);
            update courseEnroll;

            CourseEnrolledOutput output = new CourseEnrolledOutput();
            output.courseEnrolRecord = courseEnroll;
            lstCourseEnrolls.add(output);
        }
        
        return lstCourseEnrolls;
    }
    
}