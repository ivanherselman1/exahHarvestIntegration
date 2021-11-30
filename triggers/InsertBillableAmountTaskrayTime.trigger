trigger InsertBillableAmountTaskrayTime on TASKRAY__trTaskTime__c (before insert, before update) {
    
    List<TASKRAY__trTaskTime__c> taskrayTimes = new List<TASKRAY__trTaskTime__c>();
    TASKRAY__trTaskTime__c tr = new TASKRAY__trTaskTime__c();
    
    List<String> ownerID = new List<String>();

    List<String> projectID = new List<String>();
    System.debug('Taskray Task Time Trigger');

    for(TASKRAY__trTaskTime__c t : Trigger.new){
        //get owner id
        System.debug('Owner id: ' + t.TASKRAY__Owner__c);
        ownerID.add(t.TASKRAY__Owner__c);
        //get project id
        System.debug('Project id: ' + t.TASKRAY__Project__c);
        projectID.add(t.TASKRAY__Project__c);      
    }
    
    List<Member_Rates__c> rates = new List<Member_Rates__c>([select id, Rate__c From Member_Rates__c
                                                              Where User__c in: ownerID]);
 
     System.debug('Rates: ' + rates);
        
      for(TASKRAY__trTaskTime__c t : Trigger.new){
                for (integer x = 0; x < rates.size(); x++){
                        t.Billing_Rate__c = rates[x].Rate__c;
                 }
      }  

}