require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should create User" do
    user = User.new(login: 'user_login', password: 'password', email: 'email')

    assert user.save
  end

  test "should update User" do
    user = users(:rogesson)

    assert user.update_attributes(login: 'log1', password: 'pas1', email: 'mai1')
  end

  test "should get user" do
    user_id = users(:rogesson).id

    assert_nothing_raised { User.find(user_id) }
  end
end
