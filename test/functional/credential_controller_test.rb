require File.expand_path("../../test_helper", __FILE__)

class CredentialControllerTest < ActionController::TestCase
	setup do
		@controller = CredentialController.new
	end

	test "the truth" do
    	assert true
	end

	test "should update credential" do
		put(:update, id: 56)
		#puts Credential.last.password
		#puts params[:password]
	end
end
