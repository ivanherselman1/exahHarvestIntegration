public class HarvestUserCallOut {
    
  
	@future(callout=true) 
    Public Static void HarvestUserCallOut(){
        
        List<HarvestIntegration__mdt> userDet = [select method__c,endpoint__c,ContentType__c,accept__c,authorization__c, user_agent__c, harvestAccountId__c 
                                                 from HarvestIntegration__mdt where resource__c = 'users'];
    
        Http http = new Http();
        HttpRequest request = new HttpRequest();
    
        request.setMethod(string.valueOf(userDet[0].method__c));
        request.setHeader('Accept', userDet[0].accept__c);
        request.setHeader('Authorization', userDet[0].authorization__c);
        request.setHeader('User-Agent', userDet[0].user_agent__c );
    	request.setHeader('Harvest-Account-Id', userDet[0].harvestAccountId__c);
     	request.setHeader('Content-Type', userDet[0].contentType__c);
        request.setEndpoint(userDet[0].endpoint__c);
    	
                  
        HttpResponse res = new HttpResponse();
        res = http.send(request);
        system.debug('the response is '+res.getBody());
    
       harvestUserModel he =  (harvestUsermodel)json.deserialize(res.getBody(), harvestUserModel.Class);
       list<contact> cList = new list<contact>();
       
        
        
        
       
       system.debug('the srList');
        
       system.debug('the harvest user model deserialised' +he);
       
       string newEndpoint;
    
    	if(he.total_pages > 1){
        	for(integer i = 2 ; i<=he.total_pages;i++) {
                newEndpoint = userDet[0].EndPoint__c+'?'+'page'+'='+'i';
            
            
       }      
    }
        
        else{
            
            for(harvestUserModel.users userA : he.users){
            
            system.debug('the userA'+userA);
            
            contact c = new contact();
            c.firstName = userA.first_name;
            c.LastName  = userA.last_name;
            c.harvId__c = userA.id;
            c.AccountId = '0011X00000iIYSdQAO';
            clist.add(c);
            
        }
        
        system.debug('the contact list' +clist);
       
        try{
            
              database.UpsertResult[] srlist =  database.upsert(cList,contact.harvId__c);
            
        } catch (DmlException e) {
            
            
            
    
}
            
            
        }
    
        
     
       
}
   }