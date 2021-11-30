public class HarvestProjectCallOut {
    
    public static httpResponse ProjectCallOut(string theEndpoint){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(theEndpoint);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setHeader('User-Agent', 'MyApp (ivan@exah.co.za)');
        request.setHeader('Authorization', 'Bearer 1848717.pt.QDXsfn5UNvNEkjFmgAiSJ6yxfUN2iF39Q47eAeEM9MByz47jwqvrH725wcDQzqcYiM-_Uh4g6BQ_fzv58EIUvw');
        request.setHeader('Harvest-Account-Id','1055284');
        
        httpResponse res = http.send(request);
        return res;
        
    }
    
    
    public static harvestProjectCallOutModel castToModel(httpresponse response){
         
        harvestProjectCallOutModel castedModel = (HarvestProjectCallOutModel)json.deserialize(response.getbody(), harvestProjectCalloutModel.class);
        return castedModel;
        
        
    }
    
   public static list<project__c> projectsToUpsert(HarvestProjectCallOutModel acc){
       
      list<project__c> prjToUps = new list<project__c>();
      map<integer,integer> projectMap = new map<integer,integer>();
      map<decimal,id> accMap = new map<decimal,id>();
      set<integer> harvAccIds = new set<integer>();
      
       //system.debug('projects '+acc.projects);
       
      //   system.debug('the size of the project list '+acc.projects.size());
       
         for(HarvestProjectCallOutModel.project projectA : acc.projects){
             
             projectmap.put(projectA.client.id, projectA.id);
             system.debug('the harvId is '+projectA.id);
             harvAccIds.add(projectA.client.id);
             system.debug('the harvIds are' +harvAccIds);
        
             
      }
       
       list<account> accl = [select id,HarvId__c from account where harvId__c IN :harvAccIds];
       for(account b : accl){
           
           
           accmap.put(b.HarvId__c,b.Id);
         
           
     }
       for(HarvestProjectCallOutModel.project projectA : acc.projects){
           
           project__c p = new project__c();
           p.Account__c = accmap.get(projectA.client.id);
           p.Name		= projectA.name;
           p.HarvId__c  = projectA.id;
           prjToUps.add(p);
           
           
       }
    
       return prjToUps;
            
   }
     
    @future(callout=true)
    public static void HarvestProjectCallOut(){
    
		String ProjectEndPoint = 'https://api.harvestapp.com/v2/projects';
        httpResponse response = ProjectCallOut(ProjectEndpoint);
        
         
        HarvestProjectCallOutModel hcm = castToModel(response);
        projectsToUpsert(hcm);
        
       
        if(hcm.total_pages > 1){
            
            
            system.debug('we got here, more than one page');
            harvestProjectCallOutModel hcmnew = new harvestProjectCallOutModel();
            
            for(integer i = 2 ; i <=hcm.total_pages ; i++){
                
                string newEndpoint = ProjectEndPoint+'?'+'page'+'='+i ;
                httpResponse newResponse = projectCallOut(newEndpoint);
                hcmnew = castToModel(newResponse);
                
                                                                   
      } 
        database.upsert(projectsToUpsert(hcmnew),project__c.harvId__c);
    } 
        database.upsert(projectsToUpsert(hcm), project__c.HarvId__c);
  }
}