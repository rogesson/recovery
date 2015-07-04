require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should create User" do
    user = User.new(login: 'user_login', password: 'password', email: 'email')
    assert user.valid?
  end
end
