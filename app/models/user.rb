class User < ActiveRecord::Base
	self.table_name = "users"

	attr_accessible :login, :password, :email

	validates :login, :password, :email, presence: true
	validates :login, :email, uniqueness: true

	has_private_messages

	has_many :credential
  has_many :note

  before_save :encrypt_password

  private

  def encrypt_password
    self.password = Digest::SHA256.hexdigest(self.password).reverse[5..-1]
  end
end
