class Credential < ActiveRecord::Base
	self.table_name = "credentials"

	belongs_to :user

	validates :login, :password, :site, presence: true 

	attr_accessible :login, :password, :site, :user_id

	before_save :enc_password

	# TODO Criar testes.
	def unsafe_password
		DigestManager.dec(self.password, session[:c_key])		
	end

	def self.search(options)
		column = options[:column] == "site" ? "site" : "login"

		self.where("#{column} LIKE ?", "%#{options[:term]}%")
	end

	private 

	def enc_password
		# Forçando c_key para testes de model.
		c_key =	session[:c_key] rescue 'aosjdoiajsdoiajsodijaosidjasd'

		self.password = DigestManager.enc(self.password, c_key)
	end
end