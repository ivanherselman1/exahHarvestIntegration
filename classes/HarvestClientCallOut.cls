public class HarvestClientCallOut {
    
    public static HttpResponse clientCallOut(String theEndpoint){

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(theEndpoint);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setHeader('User-Agent', 'MyApp (ivan@exah.co.za)');
        request.setHeader('Authorization', 'Bearer 1848717.pt.QDXsfn5UNvNEkjFmgAiSJ6yxfUN2iF39Q47eAeEM9MByz47jwqvrH725wcDQzqcYiM-_Uh4g6BQ_fzv58EIUvw');
        request.setHeader('Harvest-Account-Id','1055284');
        
        HttpResponse res = http.send(request);
        return res;
        
    }
    
    
    public static HarvestClientCallOutModel castToModel(HttpResponse response){
         
        HarvestClientCallOutModel castedModel = (HarvestClientCallOutModel)JSON.deserialize(response.getBody(), HarvestClientCallOutModel.class);
        return castedModel;
    
        
        
    }
    
   public static List<Account> accountsToUpsert(HarvestClientCallOutModel acc){
       
      List<Account> accToUps = new List<Account>();
      for(HarvestClientCallOutModel.Client clientA : acc.clients){
          
          Account a = new Account();
          a.Name = clientA.name;
          a.HarvId__c = clientA.id;
          accToUps.add(a);
           
     }
      
       return accToUps;
            
   }
     
    @Future(Callout=true)
    public static void HarvestClientCallOut(){
    
		String ClientEndPoint = 'https://api.harvestapp.com/v2/clients';
        HttpResponse response = clientCallOut(ClientEndPoint);
        
         
        HarvestClientCallOutModel hcm = castToModel(response);
        Database.upsert(accountsToUpsert(hcm), Account.harvId__c);
       
        if(hcm.total_pages > 1){
            
            
            
            for(Integer i = 2 ; i <=hcm.total_pages ; i++){
                
                String newEndpoint = ClientEndPoint+'?'+'page'+'='+i ;
                HttpResponse newResponse = clientCallOut(newEndpoint);
                HarvestClientCallOutModel hcmnew = castToModel(newResponse);
                Database.upsert(accountsToUpsert(hcmnew),Account.harvId__c);
                                                           
      } 
    } 
  }
}