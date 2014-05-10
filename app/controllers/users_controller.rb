class UsersController < ApplicationController
	skip_before_filter :verify_active_session, only: :create
	
	#post /users
	def create
		if params[:password_conf] == params[:password]
			User.create(
				:login 	  => params[:login],
			 	:password => Digest::SHA256.hexdigest(params[:password]),
			 	:email    => params[:email]
			)
		else
			redirect_to :back			
		end
	end

	#get /users/:id
	def show
	  	if params[:type] == "1"
	  		#type 1 is search by site name ;D
	  		search_query = "AND site LIKE '%#{params[:search]}%'" 
	  	elsif params[:type] == "2"
	  		#type 1 is search by login
	  		search_query = "AND login LIKE '%#{params[:search]}%'"
	  		 
	  	elsif params[:type] == "3"
	  		#type 1 is search by password
	  		#needed?
	  		search_query = "AND password LIKE '%#{params[:search]}%'"
	  	end

	  	@passwords = Credential.where("user_id = #{session[:user_id]} #{search_query}")
	  	
	end

end