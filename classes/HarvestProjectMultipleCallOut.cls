public class HarvestProjectMultipleCallOut {
@future(callout=true)
    public static void callOutToHarvest(String URL, Integer total_pages){
        
        List<List<Project__c>> allPeList = new List<List<Project__c>>();
        string paramSym = '?'; //FOR BUILDING URL
        string page = 'page=';// FOR BUILDING URL
        String pageSpecificEndPoint;
        
       //GET ACCOUNTS AND CREATE ACCOUNT MAP
       List<Account> accList = new List<Account>();
       accList = [SELECT Id, HarvId__c FROM Account WHERE HarvId__c !=null];
       Map<Decimal, Account> accMap = new Map<Decimal,Account>();
        for(Account acc : accList){
            accMap.put(acc.HarvId__c,acc);
        }
       
       
          for(Integer i=1;i<=total_pages;i++){ //remember to make total pages later
            
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
        	system.debug('THE RESPONSE BODY IS '+RES);
            res = http.send(request);
       		HarvestProjectCallOutValues calloutResponse = (HarvestProjectCallOutValues) JSON.deserialize(res.getBody(), HarvestProjectCallOutValues.class);
              
            List<Project__c> projects = new List<Project__c>();
              
            for (HarvestProjectCallOutValues.project project : calloutResponse.projects) {
                
                account a = accMap.get(project.client.id);
                
                if(a!=null){
                    
                    projects.add(
                	 new Project__c(
                         
                         Name         = project.name,
                         HarvId__c    = project.id,
                         Account__c   = a.Id
                         
                    
                       ));
                   
                }    
                
                 else{
                     
                     projects.add(
                	 new Project__c(
                         
                         Name         = project.name,
                         HarvId__c    = project.id
                         //Account__c   = a.Id
                         
                    
                       ));
                     
              }    
            }
              
           allPeList.add(projects);  
            
              
                   
                  
        }  
        
        for(List<Project__c> pr2Up : allPeList){
                  
                  try{
                   system.debug('PR2UP SIZE IS '+PR2UP.SIZE());
                   database.upsert(pr2Up, Project__c.HarvId__c, false);
                  
              }
                  
                catch(exception e){
      }      
    }
  }   
}