require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:rogesson)
  end

  test 'shoud get index' do
    login_as(:rogesson)
    get :index

    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:users)
  end

  test 'should get user' do
    login_as(:rogesson)
    get :show, id: @user.to_param

    assert_response :success
    assert_template 'show'
    assert_not_nil assigns(:user)
    assert assigns(:user).valid?
  end
end
