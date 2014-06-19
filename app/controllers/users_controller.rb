class UsersController < ApplicationController
	skip_before_filter :verify_active_session, only: :create

	#post /users
	def create

		user = User.new(
			:login 	  => params[:login],
		 	:password => safe_password,
		 	:email    => params[:email]
		)

		if user.save
			notice = "User created!"
		else
			notice = user.errors.full_messages[0]
		end

		redirect_to :back, :flash => {:notice => notice}
	end

	#get /users/:id
	def show
	
	end  
	
	private
	def digest_secure
		Gibberish::AES.new(session[:c_key])
	end

	def safe_password
		Digest::SHA256.hexdigest(params[:password]).reverse[5..-1]
	end
end