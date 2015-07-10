require 'test_helper'

class CredentialTest < ActiveSupport::TestCase
  test 'should create credential' do
    assert user.credential.create(login: 'fake_login', password: 'fake_password', site: 'fake_site')
  end

  test 'should get credential' do
    credential_id = user.credential.first.id

    assert_nothing_raised { Credential.find(credential_id) }
  end


  test 'should update credential' do
    assert user.credential.first.update_attributes(login: 'log', password: 'pas', site: 'sit')
  end

  test 'should destroy credential' do
    credential = user.credential.first
    credential.destroy

    assert_raise(ActiveRecord::RecordNotFound) { Credential.find(credential.id) }
  end

  test 'should validate attributes' do
    credential = Credential.new

    assert !credential.valid?
    assert credential.errors[:login].any?
    assert credential.errors[:password].any?
    assert credential.errors[:site].any?

    assert_equal ["can't be blank"], credential.errors[:login]
    assert_equal ["can't be blank"], credential.errors[:password]
    assert_equal ["can't be blank"], credential.errors[:site]
  end

  test 'should search by site' do
    options = { column: 'site', term: 'www.hotmail.com' }
    credential = Credential.search(options)
    
    assert_present credential
    assert_equal 1, credential.count
  end

  test 'should not find by site' do
    options =  { column: 'site', term: 'www.nosite.com' }
    credential = Credential.search(options)
    
    assert_empty credential
    assert_equal 0, credential.count
  end

  test 'should search by login' do
    options = { column: 'login', term: 'rogesson@hotmail.com' }
    credential = Credential.search(options)
    
    assert_present credential
    assert_equal 1, credential.count
  end

  test 'should not find by login' do
    options =  { column: 'login', term: 'xxxxxx@hotmail.com' }
    credential = Credential.search(options)
    
    assert_empty credential
    assert_equal 0, credential.count
  end

  test 'should decript password' do
    credential = Credential.first
    credential.update_attributes(password: 'another_secret_pass')

    assert_not_equal 'another_secret_pass', credential.password
    assert_equal 'another_secret_pass', credential.unsafe_password
  end

  private

  def user
    users(:rogesson)
  end
end
