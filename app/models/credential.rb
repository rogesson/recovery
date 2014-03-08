class Credential < ActiveRecord::Base
	self.table_name = "credentials"

	attr_accessible :login, :password, :site, :user_id

	def encrypt
		@salt = "123"
		Digest::SHA1.hexdigest("--#{@salt}--#{self.password}--")
		e = Encode.new("abc")
		pas1 = e.encrypt
	end
	
	def decript

	end
end