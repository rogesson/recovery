require File.expand_path("../../test_helper", __FILE__)

class CredentialTest < ActiveSupport::TestCase
	setup do
		@session_id =  1
	end
   
   	test "the truth" do
    	assert true
   	end

   	test "should change password" do
   		
   		rand_pass = Random.rand 92983

   		Credential.last.change_password "#{rand_pass.to_s}"
   		
   		assert_equal Credential.where(:user_id => 5).last.password, rand_pass.to_s
   	end

   	#test "should not change my password" do
	#	rand_pass = Random.rand 92983   		
	#
	#end
end
