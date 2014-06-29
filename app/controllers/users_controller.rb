class UsersController < ApplicationController
	skip_before_filter :verify_active_session, only: :create

	#post /users
	def create

		user = User.new(
			:login 	  => params[:login],
		 	:password => Digest::SHA256.hexdigest(params[:password]).reverse[5..-1],
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
		@user = User.find(params[:id])
	end

	def index
		@users = User.where("id != ?", session[:user_id])
	end  
	
	private
	def digest_secure
		Gibberish::AES.new(session[:c_key])
	end
end