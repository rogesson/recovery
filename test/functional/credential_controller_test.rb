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
    assert_present assigns(:credentials_result)
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
    assert_equal "success", assigns(:response)
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

    assert_equal "success", assigns(:response)
  end

  test 'should destroy credential' do
    login_as(:rogesson)
    
    assert_difference('Credential.count', -1) do
      delete :destroy, id: credentials(:gmail_login).to_param
    end
    assert_equal "success", assigns(:response)
  end

  test 'should search by site' do
    login_as(:rogesson)
    get :index, { column: 'site', term: 'www.hotmail.com' }

    assert_present assigns(:credentials_result)
    assert_equal 1, assigns(:credentials_result).count
  end

  test 'should not search by site' do
    login_as(:rogesson)
    get :index, { column: 'site', term: 'www.nosite.com' }

    assert_empty assigns(:credentials_result)
    assert_equal 0, assigns(:credentials_result).count
  end

  test 'should search by login' do
    login_as(:rogesson)
    get :index, { column: 'login', term: 'rogesson@hotmail.com' }

    assert_present assigns(:credentials_result)
    assert_equal 1, assigns(:credentials_result).count
  end

  test 'should not search by login' do
    login_as(:rogesson)
    get :index, { column: 'login', term: 'xxxxxx@hotmail.com' }

    assert_empty assigns(:credentials_result)
    assert_equal 0, assigns(:credentials_result).count
  end
end
