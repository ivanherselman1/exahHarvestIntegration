public class HarvestTimeEntryCallOutModel {
    
    public list<time_entry> time_entries;
    public integer total_pages;
    public integer page;
    
    
    
    
    
    public class time_Entry {
        
       public integer id;
       public decimal rounded_hours;
       public project project;
       public decimal billable_rate;
       public boolean billable;
       public dateTime created_at;
        
   }
    
    public class project {
        
        public integer id;
        public string name;
   }
    
    public class user_assignment{
      public  integer id;
        
    }
    
   
}