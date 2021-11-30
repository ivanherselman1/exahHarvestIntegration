public class HarvestClientMultipleCallOut {
    
	@future(callout=true)
    public static void callOutToHarvest(String URL, Integer total_pages){
        
        List<List<Account>> allAccountList = new List<List<Account>>();
        string paramSym = '?'; //FOR BUILDING URL
        string page = 'page=';// FOR BUILDING URL
        String pageSpecificEndPoint;
        
    
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
        
            res = http.send(request); // Save entries only after this line
            
            
            system.debug('the response is '+res.getBody());
            
            
            HarvestClientCallOutValues calloutResponse = (HarvestClientCallOutValues) JSON.deserialize(res.getBody(), HarvestClientCallOutValues.class);
            
            
           List<Account> accList = new List<Account>();
           
           for (HarvestClientCallOutValues.client client : calloutResponse.clients) {
               
                 accList.add(new Account(HarvId__c = client.id,
                                         Name      = client.name ));
                                        	
           	    allAccountList.add(accList);
        }
            
        for(List<Account> listToUpsert : allAccountList){
            
             database.upsert(listToUpsert, Account.harvId__c, true);
   }
  }      
 }
}