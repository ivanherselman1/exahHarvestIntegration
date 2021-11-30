public class HarvTimeEntryMultipleCallOut {

    @future(callout=true)
    public static void callOutToHarvest(String URL, Integer total_pages){
        
        List<List<TimeEntry__c>> allTeList = new List<List<TimeEntry__c>>();
        string paramSym = '?'; //FOR BUILDING URL
        string page = 'page=';// FOR BUILDING URL
        String pageSpecificEndPoint;
        
        //Create contactMap to get contact from system and associate with Time_Entry
        
        List<contact> contList = new List<contact>();
        contList = [SELECT Id, HarvId__c 
                    FROM contact 
                    WHERE HarvId__c !=null];
        
        Map<Decimal,Contact> contMap = new Map<Decimal,contact>();
        
        for(contact c : contList){
            
            contMap.put(c.HarvId__c, c);
            system.debug('CONTMAP ARE '+contMap);
        }
        
        List<Project__c> prList = new List<Project__c>();
        prList = [SELECT Id, HarvId__c 
                  FROM Project__c 
                  WHERE HarvId__c !=null];
        
        system.debug('HERE IS THE PRLIST '+prList.size()); //101 project records found and put into list
        Map<Decimal,project__c> prMap = new Map<Decimal,project__c>(); //map successfully created
        
        for(project__c pr : prList){
            
            prMap.put(pr.HarvId__c, pr); //map with 101 map entries created 
            system.debug('THE PROJECT MAP CONTAINS '+prMap);
        }
        
        for(Integer i=1;i<=20;i++){ //remember to make total pages later
            
            pageSpecificEndPoint = url+paramSym+page+i;
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            
            request.setEndpoint(pageSpecificEndPoint);
            request.setMethod('GET');
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Accept', 'application/json');
            request.setHeader('User-Agent', 'MyApp (ivan@exah.co.za)');
            request.setHeader('Authorization', 'Bearer 1848717.pt.QDXsfn5UNvNEkjFmgAiSJ6yxfUN2iF39Q47eAeEM9MByz47jwqvrH725wcDQzqcYiM-_Uh4g6BQ_fzv58EIUvw');
            request.setHeader('Harvest-Account-Id','1055284');
        
        	system.debug('THE PAGE SPECIFIC ENDPOINT IS '+pageSpecificEndPoint);
        
        	HttpResponse res = new HttpResponse();
        
            res = http.send(request); // Save entries only after this line
            
            
            system.debug('the response is '+res.getBody());
            
            //Map<String,Object> responseMap = new Map<String,Object>();
            HarvestTimeEntryCallOutValues calloutResponse = (HarvestTimeEntryCallOutValues) JSON.deserialize(res.getBody(), HarvestTimeEntryCallOutValues.class);
            //system.debug('Response map after conversion'+ calloutResponse);
            
            List<TimeEntry__c> timeEntries = new List<TimeEntry__c>();
            for (HarvestTimeEntryCallOutValues.TimeEntry timeEntry : calloutResponse.time_entries) {
                 
             	
                 
                 contact teamMember = contMap.get(timeEntry.User.id);
                 system.debug('THE TEAM MEMBER ID IS' +teamMember);
                 project__c teProject  = prMap.get(timeEntry.Project.id);
                
                if(teProject==null)
                {system.debug('PROJECT NOT FOUND');}
                else{system.debug('THE SFDC PROJECT ID IS'+teProject.Id);}
                 
                if(teProject==null){
                    
                     timeEntries.add(
                	 new TimeEntry__c(
                    	HarvestId__c     = timeEntry.id,
                      	rounded_hours__c = timeEntry.rounded_hours,
                        Billable_Rate__c = timeEntry.billable_rate,
                        //project__c 		 = teProject.Id,
                        team_member__c   =  teamMember.Id
                       ));
                    
                
                }
                
                else{
                    
                    
                    timeEntries.add(
                	new TimeEntry__c(
                    	HarvestId__c     = timeEntry.id,
                      	rounded_hours__c = timeEntry.rounded_hours,
                        Billable_Rate__c = timeEntry.billable_rate,
                        Project__c 		 = teProject.Id,
                        team_member__c   =  teamMember.Id
                       ));
                    
                }
                        
                            
                
            }
            
            system.debug('Time entry salesforce List: '+ timeEntries);
            system.debug('List size: '+ timeEntries.Size());
          	
            allTeList.add(timeEntries);
        }
        
        for(List<TimeEntry__c> listToUpsert : allTeList){
            
            database.upsert(listToUpsert, TimeEntry__c.harvestId__c, true);
        }
               
          
           system.debug('THE SIZE OF THE LIST OF LISTS IS '+allTeList.size());
  }
}