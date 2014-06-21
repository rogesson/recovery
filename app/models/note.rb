class Note < ActiveRecord::Base
   self.table_name = "notes"

   attr_accessible :title, :body, :user_id
end
