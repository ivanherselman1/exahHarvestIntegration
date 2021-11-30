public class HarvestTimeEntryCallOut {

    public static String timeEntryEndPoint = 'https://api.harvestapp.com/v2/time_entries';


    public List<TimeEntry__c> teToUps = new List<TimeEntry__c>();

    public static HttpResponse TimeEntryCallOut(String theEndpoint) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(theEndpoint);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setHeader('User-Agent', 'MyApp (ivan@exah.co.za)');
        request.setHeader('Authorization', 'Bearer 1848717.pt.QDXsfn5UNvNEkjFmgAiSJ6yxfUN2iF39Q47eAeEM9MByz47jwqvrH725wcDQzqcYiM-_Uh4g6BQ_fzv58EIUvw');
        request.setHeader('Harvest-Account-Id', '1055284');

        HttpResponse res = http.send(request);
        return res;

    }


    public static HarvestTimeEntryCallOutModel castToModel(HttpResponse response) {

        HarvestTimeEntryCallOutModel castedModel = (HarvestTimeEntryCallOutModel) JSON.deserialize(response.getBody(), HarvestTimeEntryCallOutModel.class);
        return castedModel;


    }

    public static List<TimeEntry__c> TimeEntriesToUpsert(List<HarvestTimeEntryCallOutModel> acc) {

        System.debug('timeEntries object passed ' + acc);
        List<TimeEntry__c> teToUps = new List<TimeEntry__c>();
        Map<HarvestTimeEntryCallOutModel.time_Entry, Integer> timeEntryMap = new Map<HarvestTimeEntryCallOutModel.time_Entry, Integer>();
        Map<Decimal, Id> projectMap = new Map<Decimal, Id>();
        Set<id> prIds = new Set<Id>();
        List<Project__c> prlist = new List<Project__c>([SELECT Id,HarvId__c FROM Project__c WHERE HarvId__c != NULL]);

       /* for (Project__c pr : prlist) {

            prIds.add(pr.id);


        }
        List<Project__c> filteredPrList = new List<Project__c>([SELECT id, HarvId__c FROM Project__c WHERE id IN :prIds]);
*/
        Set<Integer> timeEntryExtId = new Set<Integer>();


        for (HarvestTimeEntryCallOutModel modello : acc) {

            for (HarvestTimeEntryCallOutModel.time_Entry entryA : modello.time_entries) {

                timeEntryExtId.add(entryA.id);

                for(Integer t : timeEntryExtId){
                   if(entryA.id != t){
                       timeEntryMap.put(entryA, entryA.project.id);

                    }

                }



                for (HarvestTimeEntryCallOutModel.time_Entry intI : timeEntryMap.keySet()) {

                    TimeEntry__c te = new TimeEntry__c();

                    te.Project__c = projectMap.get(intI.project.id);
                    te.HarvestId__c = intI.id;
                    te.Billable_Rate__c = intI.billable_rate;
                    te.Rounded_Hours__c = intI.rounded_hours;

                    System.debug('the Time Entry Record will look like this ' + te);
                    teToUps.add(te);


                }
            }

        } // END OF FOR LOOPS

        System.debug('the list to upsert is ' + teToUps);
        System.debug('and the size is  ' + teToUps.size());


            return teToUps;

        }

        @Future(Callout=true)
        public static void HarvestTimeEntryCallOut(){

            List<HarvestTimeEntryCallOutModel> htList = new List<HarvestTimeEntryCallOutModel>();
            HttpResponse response = TimeEntryCallOut(timeEntryEndPoint);
            HarvestTimeEntryCallOutModel hcm = castToModel(response);
            htList.add(hcm);

        for(Integer i=2;i<=hcm.total_pages;i++){

            String newEndpoint = timeEntryEndPoint+'?'+'page'+'i';
            HttpResponse newResponse = TimeEntryCallOut(newEndpoint);
            HarvestTimeEntryCallOutModel hcm2 = castToModel(newResponse);
            htList.add(hcm2);
            //this is not working is it now plus extra changes hey wena ++
        }
       system.debug('the size of the list is '+htlist.size());
       list<TimeEntry__c> tEl =  TimeEntriesToUpsert(htList);
            system.debug('ag nee man');
            try {

                Database.UpsertResult[] results = Database.upsert(tEl, false);
                for(Integer i=0;i<results.size();i++){

                    if (!results.get(i).isSuccess()){
                        Database.Error err = results.get(i).getErrors().get(0);
                        System.debug('Error - '+err.getMessage() + '\nStatus Code : '+err.getStatusCode()+'\n Fields : '+err.getFields());
                    }
                }

            } catch (DmlException e) {


            }




    }







    // database.upsert(timeEntriesToUpsert(htList), timeEntry__c.harvestId__c);
  }
