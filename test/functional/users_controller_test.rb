require File.expand_path("../../test_helper", __FILE__)

class UsersControllerTest < ActionController::TestCase
	setup do
		@controller = UsersController.new
		session[:user_id] = 5
	end

	test "the truth" do
		assert true
	end

	test "should search by site" do
		get(:show, id: 5, type: "1", search: "google.com")
		puts @response.body
		#assert_equals
	end
end