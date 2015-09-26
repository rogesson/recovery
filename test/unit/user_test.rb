require 'test_helper'

# User model
class UserTest < ActiveSupport::TestCase
  test 'should create User' do
    user = User.new(login: 'user_login', password: 'password', email: 'email')

    assert user.save
  end

  test 'should update User' do
    user = users(:rogesson)

    assert user.update_attributes(
      login: 'log1',
      password: 'pas1',
      email: 'mai1')
  end

  test 'should get User' do
    user_id = users(:rogesson).id

    assert_nothing_raised { User.find(user_id) }
  end

  test 'should destroy User' do
    user = users(:rogesson)
    user.destroy

    assert_raise(ActiveRecord::RecordNotFound) { User.find(user.id) }
  end

  test 'should validate presence of attributes' do
    user = User.new

    assert !user.valid?
    assert user.errors[:login].any?
    assert user.errors[:email].any?
    assert user.errors[:password].any?

    assert_equal ["can't be blank"], user.errors[:login]
    assert_equal ["can't be blank"], user.errors[:email]
    assert_equal ["can't be blank"], user.errors[:password]
  end
end
