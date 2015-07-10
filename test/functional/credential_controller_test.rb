require 'test_helper'

class CredentialsControllerTest < ActionController::TestCase
  setup do
    @user = users(:rogesson)
  end

  test 'should get index' do
    login_as(:rogesson)

    get :index

    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:credentials)
  end

  test 'should create credential' do
    login_as(:rogesson)

    credential_params = { 
                          credential: {
                            login: 'loginfake123',
                            password: 'passwordfake123',
                            site: 'sitefake123'
                          }
                        }

    assert_difference('Credential.count') do
      post :create, credential_params
    end
    assert_response :success
  end


  test 'should not create credential' do
    login_as(:rogesson)

    credential_params = { 
                          credential: {
                            login: 'loginfake123'
                          }
                        }

    assert_no_difference('Credential.count') do
      post :create, credential_params
    end
  end

  test 'should update credential' do
    login_as(:rogesson)
    put :update, id: credentials(:gmail_login).to_param, credential: { password: 'newpassword!222' }

    assert_response :success
  end

  test 'should destroy credential' do
    login_as(:rogesson)
    
    assert_difference('Credential.count', -1) do
      delete :destroy, id: credentials(:gmail_login).to_param
    end
    assert_response :success
  end
end
