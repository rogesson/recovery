class Credential < ActiveRecord::Base
	self.table_name = "credentials"

	attr_accessible :login, :password, :site, :user_id
end