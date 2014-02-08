class UserController < ActionController::Base
  def show
  	@user = User.find(params["id"].to_i)
  	@passwords = Credential.find_all_by_user_id(@user.id)
  end
end