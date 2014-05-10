require File.expand_path("../../test_helper", __FILE__)

class CredentialsControllerTest < ActionController::TestCase
	setup do
		@controller = CredentialsController.new
	end

	test "the truth" do
    	assert true
	end

	test "should update credential" do
		put(:update, id: 56, :password => "newpass")
		
		assert_equal @response.body, {response: 200}.to_json
	end

	test "shouldn't update credential" do
		put(:update, id: 22, :password => "newpass")
		
		assert_equal @response.body, {response: 500}.to_json
	end
end