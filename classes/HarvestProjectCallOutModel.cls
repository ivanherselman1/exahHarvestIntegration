public class HarvestProjectCallOutModel {
    
  	public List<Project> projects;
  	public Integer per_page;
	public Integer total_pages;
	public Integer total_entries;
	public Integer next_page;
	public Integer page;
	public Links links;  
    
 public class Project {
        
		public integer id;
		public String name;
		public String code;
		public Boolean is_active;
		public Boolean is_billable;
		public Boolean is_fixed_fee;
		public String bill_by;
		//public Object budget;
		public String budget_by;
		public Boolean budget_is_monthly;
		public Boolean notify_when_over_budget;
		public Double over_budget_notification_percentage;
		public Boolean show_budget_to_all;
		public String created_at;
		public String updated_at;
		public String notes;
	
		public Boolean cost_budget_include_expenses;
		public Client client;
       
   } 
     

  public class Links {
        
		public String first;
		public String next;
		public String last;
      
      
	}

	public class Client {
        
		public Integer id;
		public String name;
		public String billCurrency;
        
	}    
        
}