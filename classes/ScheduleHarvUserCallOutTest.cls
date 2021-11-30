@isTest
public class ScheduleHarvUserCallOutTest {
    
 static testmethod void testFunc() {
  
Test.StartTest();
   
ScheduleHarvUserCallOut sh1 = new ScheduleHarvUserCallOut();
    
     String sch = '0 0 23 * * ?';
     system.schedule('Test schexample', sch, sh1);
	 Test.stopTest();
   
  }
 }