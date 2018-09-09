/*----------------------------------------------------------------------
Name:       CourseEnrolledInsertAction.cls
Purpose:    Insert CourseEnrolled__c record
------------------------------History----------------------------------
Version     Author              Date                        Detail Description 
-------     --------------      -----------------           ------------------
1.0         Muhammad Abrar      10-September-2018           Initial Development 
----------------------------------------------------------------------*/
public with sharing class CourseEnrolledInsertAction{

    public class CourseEnrolledInput {
        @InvocableVariable(required=true)
        public String contactEmailAddress;

        @InvocableVariable(required=true)
        public String selectedLocation;
        
        @InvocableVariable(required=true)
        public Course__c courseRecord;
    }   

    public class CourseEnrolledOutput {
        @InvocableVariable(required=true)
        public CourseEnrolled__c courseEnrolledRecord;
    }

    /*----------------------------------------------------------------------
    Purpose:    Insert CourseEnrolled__c record
    Parameters: CourseEnrolledInput
    Returns:    CourseEnrolledOutput
    ------------------------------History----------------------------------
    Version     Author              Date                        Detail Description 
    -------     --------------      -----------------           ------------------
    1.0         Muhammad Abrar      10-September-2018           Initial Development
    ----------------------------------------------------------------------*/
    @InvocableMethod(label='Insert Course Enrolled' description='Create Course Enrolled record.')
    public static List<CourseEnrolledOutput> insertCourseEnrolled(List<CourseEnrolledInput> inputs) {
        List<CourseEnrolledOutput> results = new List<CourseEnrolledOutput>();

        for(CourseEnrolledInput input : inputs){
            User userRecord = [SELECT Id, Name, AccountId, ContactId FROM User WHERE Id = :Userinfo.getUserId() LIMIT 1];
            
            //Account accountRecord = [SELECT Id FROM Account WHERE Name = 'FutureSkills' LIMIT 1];
            Contact contactRecord = [SELECT Id, Name, Email, AccountId, Account.Name FROM Contact WHERE Email = :input.contactEmailAddress LIMIT 1];
            
            CourseEnrolled__c courseEnrolled = new CourseEnrolled__c();
                courseEnrolled.Account__c = contactRecord.AccountId;//accountRecord.Id;
                courseEnrolled.Contact__c = contactRecord.Id;
                courseEnrolled.Course__c = input.courseRecord.Id;
                courseEnrolled.StartDate__c = System.today()+5;
                courseEnrolled.EndDate__c = System.today()+10;
                courseEnrolled.Location__c = input.selectedLocation;
            insert courseEnrolled;
            
            CourseEnrolled__c querycourseEnrolled = [SELECT Id, Name, Account__c, Contact__c, 
                                                    Course__c, Course__r.Name, Course__r.Description__c, Course__r.Duration__c, Course__r.Frequency__c, Course__r.Institution__r.Name,
                                                    StartDate__c, EndDate__c, Location__c FROM CourseEnrolled__c WHERE Id =:courseEnrolled.Id LIMIT 1];

            CourseEnrolledOutput output = new CourseEnrolledOutput();
                output.courseEnrolledRecord = querycourseEnrolled;
            results.add(output);
        }

        return results;
    }
    
}