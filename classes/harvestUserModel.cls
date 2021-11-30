public class harvestUserModel {

  
	public List<Users> users;
	public Integer per_page;
	public Integer total_pages;
	public Integer total_entries;
	public Integer page;
	
    
  public class Users {
        
        
        
		public Integer id;
		public String first_name;
		public String last_name;
		public String email;
		public String telephone;
		public String timezone;
		public Integer weekly_capacity;
		public Boolean has_access_to_all_future_projects;
		public Boolean is_contractor;
		public Boolean is_admin;
		public Boolean is_project_manager;
		public Boolean can_see_rates;
		public Boolean can_create_projects;
		public Boolean can_create_invoices;
		public Boolean is_active;
		public Boolean calendar_integration_enabled;
		public String created_at;
		public String updated_at;
		public Double default_hourly_rate;
		public Double cost_rate;
		public List<String> roles;
		public String avatar_url;
        
       
  }
}