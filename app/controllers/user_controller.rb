class UserController < ActionController::Base
  def show
  	if params[:search].nil?
  	 #@user = User.find(params["id"].to_i)
  	 @passwords = Credential.find_all_by_user_id(params["id"].to_i)
  	
  	elsif params[:type] == "1"
  		#type 1 is search by site name ;D
  		@passwords = Credential.find_by_sql "select * from credentials where user_id = #{params["id"]} and site like '%#{params[:search]}%'" 
  	end

  end
end