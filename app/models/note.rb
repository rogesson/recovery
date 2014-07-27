class Note < ActiveRecord::Base
   self.table_name = "notes"

   attr_accessible :title, :body, :user_id

   default_scope order("id desc")

   def short_title
   	if self.title.size < 10
   		"#{self.title}".capitalize[0..9]
   	else
   		"#{self.title.capitalize[0..9]}..."
   	end 
   end

   def safe_body
   	digest_secure = Gibberish::AES.new(session[:c_key])
		digest_secure.dec(self.body)	
   end
end
