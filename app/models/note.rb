class Note < ActiveRecord::Base
   self.table_name = "notes"

   attr_accessible :title, :body, :user_id

   def short_title
   	if self.title.size < 10
   		"#{self.title}".capitalize[0..9]
   	else
   		"#{self.title.capitalize[0..9]}..."
   	end 

   end
end
