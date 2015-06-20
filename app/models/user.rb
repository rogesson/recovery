class User < ActiveRecord::Base
	self.table_name = "users"

	attr_accessible :login, :password, :email

	validates :login, :password, :email, presence: true
	validates :login, :email, uniqueness: true

	has_private_messages

	has_many :credential
end
