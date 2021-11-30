public class HarvestClientCallOutModel {
    
        public List<Client> clients;
        public Integer per_page;
        public Integer total_pages;
        public Integer total_entries;
        public Integer page;
        
    
 public class client {
                
		public Integer id;
		public String name;
		public Boolean is_active;
		public String statement_key;
		public String created_at;
		public String updated_at;
		public String billcurrency;
        
 
   }
}