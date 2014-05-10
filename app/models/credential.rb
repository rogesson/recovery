class Credential < ActiveRecord::Base
	self.table_name = "credentials"


	attr_accessible :login, :password, :site, :user_id
=begin  [Deprecated] 09/5/2014
	def encrypt
		@salt = "123"
		Digest::SHA1.hexdigest("--#{@salt}--#{self.password}--")
		e = Encode.new("abc")
		pas1 = e.encrypt
	end
	
	def decript

	end
=end
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