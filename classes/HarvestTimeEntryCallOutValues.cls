public class HarvestTimeEntryCallOutValues {
    
    public List<TimeEntry> time_entries;//time_entries get cast into this list
	public Integer per_page;
	public Integer total_pages;
	public Integer total_entries;
	public Integer next_page;
	//public Object previous_page;
	public Integer page;
	public Links links;
    	 
	public class TimeEntry { //each invidual TimeEntry has these properties/attributes
           
        
		
		public Integer id;
		public String spent_date;
		public Double hours;
		public Double rounded_hours;
		public String notes;
		public Boolean is_locked;
        public Double billable_rate;
        public Project project;
        public User user;
     /*   
		//public Object locked_reason;
		public Boolean is_closed;
		public Boolean is_billed;
		//public Object timer_started_at;
		public String started_time;
		public String ended_time;
		public Boolean is_running;
		public Boolean billable;
		public Boolean budgeted;
		
		public Double cost_rate;
		public String created_at;
		public String updated_at;
		
		public Client client;
		
		public User task;
		public User_assignment user_assignment;
		public Task_assignment task_assignment;
		//public Object invoice;
		//public Object external_reference;
        
    */   
  
	}

	public class Project {
        
		public integer id;
		public String name;
		public String code;
	}

	public class User {
        
		public Integer id;
		public String name;
	}

	public class User_assignment {
		public Integer id;
		public Boolean is_project_manager;
		public Boolean is_active;
		public Boolean use_default_rates;
		//public Object budget;
		public String created_at;
		public String updated_at;
		public Double hourly_rate;
	}

	

	public class Task_assignment_Z {
		public Integer id;
		public Boolean billable;
		public Boolean is_active;
		public String created_at;
		public String updated_at;
		public Double hourly_rate;
		//public Object budget;
	}

	public class Task_assignment {
		public Integer id;
		public Boolean billable;
		public Boolean is_active;
		public String created_at;
		public String updated_at;
		//public Object hourly_rate;
		//public Object budget;
	}

	public class Links {
		public String first;
		public String next;
		//public Object previous;
		public String last;
	}

	public class Client {
        
		public Integer id;
		public String name;
		public String billcurrency;
	}

}