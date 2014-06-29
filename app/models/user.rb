class User < ActiveRecord::Base
	self.table_name = "users"

	has_many :credential
	validates :login, presence: true
	validates :login, uniqueness: true
	validates :password, presence: true
	validates :email, presence: true
	validates :email, uniqueness: true
	attr_accessible :login, :password, :email

	has_private_messages
end
