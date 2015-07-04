require 'test_helper'

# Class for credential test
class CredentialTest < ActiveSupport::TestCase
  test 'should create credential' do
    credential = Credential.new
    credential.user = users(:rogesson)
    credential.login = 'fake_login'
    credential.password = 'fake_password'
    credential.site = 'fake_site'

    assert credential.save
  end
end
