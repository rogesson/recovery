class Credential < ActiveRecord::Base
	self.table_name = "credentials"

	belongs_to :user

	validates :login,    presence: true 
	validates :password, presence: true 
	validates :site,     presence: true 


	attr_accessible :login, :password, :site, :user_id

	default_scope order "id desc"
	default_scope limit 10
	

	def change_password  new_password
   		status = false

   		if self.tainted? 

	   		if self.user_id == session[:user_id]
	   			self.untaint
	   			if !self.tainted?
		   			self.password = new_password
		   			self.save
		   			status = true
	   			end
	   		end
   		end
	    
	    status
	end

	def safe_delete
		if self.user_id == session[:user_id]
			self.delete
		end
	end

	def unsafe_password
		digest_secure = Gibberish::AES.new(session[:c_key])
		digest_secure.dec(self.password)		
	end

	private
	def digest_secure
		Gibberish::AES.new(session[:c_key])
	end
end