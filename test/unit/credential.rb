require File.expand_path("../../test_helper", __FILE__)

class CredentialTest < ActiveSupport::TestCase
	setup do
	#session[:user_id] = 5

	end

   
   	test "the truth" do
    	assert true
   	end

   	test "should change password" do
   		
   		status = false
   		id = 56
   		credential = Credential.find(id).taint

   		password = "npass"
   		

   		if credential.user_id == 5
   			status = false
   			credential.untaint
   			if credential.tainted? == false
   				status = true
	   			credential.password = password
	   			credential.save
   			end
   		end

   		puts status
   	end
end
