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
end
