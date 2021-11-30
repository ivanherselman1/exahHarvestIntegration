@isTest(seeAllData=true)
public class HarvestUserCallOutTest {
    
   @isTest public static void firstCallOut(){
        
     //staticresource HarvUserStat1 = new staticresource();
     //HarvUserStat1.body = blob.valueOf('{"users":[{"first_name":"Ivan","last_name":"Herselman","email":"bobpowell@example.com","cost_rate":75.0,"id":1782884}]}');
     //staticresource HarvUserStat2 = new staticresource();
     //HarvUserStat2.body = blob.valueOf('{"users":[{"first_name":"Ivan","last_name":"Herselman","email":"bobpowell@example.com","cost_rate":75.0,"id":1782884}]}');
         
     MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
     mock.setStaticResource('https://api.harvestapp.com/v2/users', 'HarvUserStat1');
     mock.setStaticResource('https://api.harvestapp.com/v2/users?page=2', 'HarvUserStat2');
     
 	
     mock.setStatusCode(200);
     mock.setHeader('Content-Type', 'application/json');
     Test.setMock(HttpCalloutMock.class, mock);
     test.startTest(); 
       
     HarvestUserCallOut.HarvestUserCallOut();
       
     test.stopTest();
             
    }
    
   /* public static void nextCallOut(){
        
        multiStaticResourceCalloutMock mock2 = new MultiStaticResourceCalloutMock();
        mock2.setStaticResource('https://api.harvestapp.com/v2/users?page=1', 'HarvUserStat2');
        mock2.setStatusCode(200);
     	mock2.setHeader('Content-Type', 'application/json');
     	Test.setMock(HttpCalloutMock.class, mock2);
        integer total_pages =1;
        string userendpoint='https://api.harvestapp.com/v2/users';
      	test.startTest(); 
     	HarvestUserMultipleCallOut.callOutToHarvest(userEndPoint, total_pages);
      	test.stopTest();
   }*/ 
    
    
  }