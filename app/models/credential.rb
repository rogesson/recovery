class Credential < ActiveRecord::Base
	self.table_name = "credentials"

	belongs_to :user

	validates :login, :password, :site, presence: true 

	attr_accessible :login, :password, :site, :user_id
	
	# TODO DELETAR
	def change_password  new_password
   		self.taint
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
	
	# TODO DELETAR
	def safe_delete
		if self.user_id == session[:user_id]
			self.delete
		end
	end

	# TODO Criar testes.
	def unsafe_password
		DigestManager.dec(self.password, session[:c_key])		
	end

	# TODO Rafatorar
	def self.search_by(params)
		column = case params[:type]
		when "1"
			"site"
		when "2"
			"login"
		else
			""
		end

		self.where("#{column} LIKE ?", "%#{params[:search]}%")
	end
end