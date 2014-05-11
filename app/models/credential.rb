class Credential < ActiveRecord::Base
	self.table_name = "credentials"

	belongs_to :user

	validates :login, presence: true 
	validates :password, presence: true 
	validates :site, presence: true 


	attr_accessible :login, :password, :site, :user_id

	def change_password  new_password
   		status = false

   		if self.tainted? == true

	   		if self.user_id == session[:user_id]
	   			status = false
	   			self.untaint
	   			if self.tainted? == false
		   			self.password = new_password
		   			self.save
		   			status = true
	   			end
	   		end

   		end
	    
	    status
	end

end