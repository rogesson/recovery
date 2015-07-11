class UsersController < ApplicationController
	skip_before_filter :verify_active_session, only: [:new, :create]

	def create
	 	user = User.new(params[:user])
	 	if user.save
		 	create_session_for(user)
			redirect_to "/home"
		else
			redirect_to "/"
		end
	end

	def show
		@user = User.find(params[:id])
	end
  
	def edit
		@user = User.find(session[:user_id])
	end

	def index
		@users = User.where("id != ?", session[:user_id])
	end

	def new
		@user = User.new
	end

	def update
		user = User.find(session[:user_id])
		response = user.update_attributes(params[:user]) ? 'success' : user.errors

		render js: { response: response }
	end

	private

	def generate_c_key
		safe_credential = "#{params[:password]}#{params[:login]}^]+^@".reverse[1..-1]
		safe_credential = Digest::SHA256.hexdigest safe_credential
	end

	def create_session_for(user)
		session[:session_id] = Random.rand(19999283)
		session[:user_id]    = user.id
		session[:c_key]      = generate_c_key
	end
end