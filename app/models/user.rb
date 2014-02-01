class User < ActiveRecord::Base
	self.table_name = "users"

	attr_accessible :login, :password, :email
end
