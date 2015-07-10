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

	private 

	def enc_password
		# Forçando c_key para testes de model.
		c_key =	session[:c_key] rescue 'aosjdoiajsdoiajsodijaosidjasd'

		self.password = DigestManager.enc(self.password, c_key)
	end
end