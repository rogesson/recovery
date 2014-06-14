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
		user_count = User.count
		request.env["HTTP_REFERER"] = "/main"
		params = {
			login: "lucass",
			password: "192083",
			email: "lucas@gmail.com"
		}
		post(:create, params)

		assert_not_equal user_count , User.count
	end

	test "shouldn't create a new user because login already exists" do
		user_count = User.count
		request.env["HTTP_REFERER"] = "/main"
		params = {
			login: User.first.login,
			password: "192083",
			email: "lucas@gmail.com"
		}
		post(:create, params)

		assert_equal user_count , User.count
	end

	test "shouldn't create user" do
		user_count = User.count
		request.env["HTTP_REFERER"] = "/main"
		params = {
			login: "",
			password: "",
			email: ""
		}
		post(:create, params)

		assert_equal user_count , User.count
	end

	test "should create a new user because email already exists" do
		user_count = User.count
		request.env["HTTP_REFERER"] = "/main"
		params = {
			login: "paulo",
			password: "0192-0912",
			email: User.first.email
		}
		post(:create, params)

		assert_equal user_count , User.count
	end

end