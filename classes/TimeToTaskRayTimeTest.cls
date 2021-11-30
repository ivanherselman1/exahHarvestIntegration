@isTest(seeAllData=false)
public class TimeToTaskRayTimeTest {
    
    public static testMethod void testTaskTime(){ 
		//Account
		Account acc = new Account();
        acc.Name = 'Test account';
        insert acc;
        
        //New TaskRay Project
        TASKRAY__Project__c project = new TASKRAY__Project__c();
        project.Account__c = acc.Id;
        project.Name = 'Test Project';
		insert project;
        
        //New TaskRay Task
        TASKRAY__Project_Task__c task = new TASKRAY__Project_Task__c();
        task.Name = 'Test Task';
        task.TASKRAY__Project__c = project.Id;
        insert task;
        
        //new Timesheet
		Timesheet__c timesheet = new Timesheet__c();
        timesheet.Taskray_Task__c = task.Id;
        insert timesheet;

        Time__c testTime = new Time__c();
        testTime.Timesheet__c = timesheet.Id;
        testTime.Start_Time__c = DateTime.now();
        testTime.End_Time__c = DateTime.now();
        insert testTime;
        
        
    } 
}