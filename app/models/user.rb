class User < ActiveRecord::Base
	self.table_name = "users"

	has_many :credential

	attr_accessible :login, :password, :email
end
