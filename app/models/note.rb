class Note < ActiveRecord::Base
   self.table_name = "notes"

   attr_accessible :title, :body

   validates :title, :body, presence: true

   belongs_to :user

   def short_title
      return if self.title.size < 10

      self.title[0..9] + "..."
   end

   # TODO refatorar
   def safe_body
   	digest_secure = Gibberish::AES.new(session[:c_key])
		digest_secure.dec(self.body)	
   end
end
