require File.expand_path("../../test_helper", __FILE__)

class UsersControllerTest < ActionController::TestCase
	setup do
		@controller = UsersController.new
		session[:user_id] = 5
	end

	test "the truth" do
		assert true
	end

	test "should create a new user" do
		user_count = puts User.count
		request.env["HTTP_REFERER"] = "/main"
		params = {
			login: "lucass",
			password: "192083",
			email: "lucas@gmail.com"
		}
		post(:create, params)

		assert_not_equal user_count , User.count
	end

end