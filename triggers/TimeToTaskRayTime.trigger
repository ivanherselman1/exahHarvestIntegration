trigger TimeToTaskRayTime on Time__c (after insert, after update) {
        List <TASKRAY__trTaskTime__c> taskTimes = new List <TASKRAY__trTaskTime__c>();
        
        List<String> ProjectIDs = new List<String>();	
        for(Time__c t : Trigger.new)
        {
            System.Debug('Project ID ='+t.Project__c);
            ProjectIDs.add(t.Project__c);
        }
        System.debug('Project IDs'+projectIDs);
        List<Member_Rates__c> rates = new List<Member_Rates__c>([select id, Rate__c, User__c, Project__c from Member_Rates__c 
  						where Project__c in:ProjectIDs]);
        System.debug('Rates '+rates);
        for(Time__c t : Trigger.new)
        {
            if(t.End_Time__c != null)
            {
                TASKRAY__trTaskTime__c tr = new TASKRAY__trTaskTime__c();
                tr.TASKRAY__Date__c = date.newinstance(t.Start_Time__c.year(), t.Start_Time__c.month(), t.Start_Time__c.day());                
                tr.TASKRAY__Hours__c = t.Duration__c;
                tr.TASKRAY__Project__c = Id.valueOf(t.Project__c);
                tr.TASKRAY__Task__c = Id.valueOf(t.Task__c);
                tr.TASKRAY__Owner__c = t.CreatedById;
                if(t.Type__c == 'Billed')
                {
                    tr.TASKRAY__Billable__c = TRUE;
                }
                tr.TASKRAY__Notes__c = t.Notes__c;
                tr.Time__c = String.valueOf(t.Id);
                
                for (integer i = 0; i < rates.size(); i++){
                  if (t.Project__c == rates[i].Project__c){
                      if(t.CreatedById == rates[i].User__c){
                          tr.Billing_Rate__c = rates[i].Rate__c;
                      }
                  }
                }
                taskTimes.add(tr);
            }
        }
        try {
            upsert taskTimes Time__c;
        } catch (system.DmlException e){
            system.debug(e);
        }
}